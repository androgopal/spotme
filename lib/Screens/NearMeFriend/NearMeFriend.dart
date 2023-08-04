import 'package:flutter/material.dart';
import 'package:spotme/Screens/UserProfile/EditProfile.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';

class NearMeFriendList extends StatelessWidget {
  const NearMeFriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Perform action when back button is pressed
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Perform action when more button is pressed
              // Example: Show a popup menu or navigate to another screen
            },
          ),
        ],),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Strings.spotMeBoard,style: TextStyle(fontSize: 39,fontFamily:FontName.simplified,fontWeight: FontWeight.bold,color: AppColor.grayColor),),
              Expanded(
                  child:GridView.builder(
                    itemCount: 100,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of items in each row
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          // Button onPressed code here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfile()),
                          );

                        },
                        child: Container(
                          // padding: const EdgeInsets.all(8.0),
                          child: const Column(
                            children: [
                              CircleAvatar(
                                radius: 30, // Adjust the radius as needed
                                backgroundImage: AssetImage('assets/images/user.png'),
                              ),
                               SizedBox(height: 8.0),
                              Text('Dino\nJames',textAlign: TextAlign.center,style: TextStyle(fontFamily:FontName.montserrat,fontWeight:FontWeight.bold ,fontSize:11,color: AppColor.appSecondaryColor ),), // Text widget
                            ],
                          ),
                        ),
                      );
                    },
                  )

              ),

            ],
          ),
        ),
      ),
    );
  }
}
