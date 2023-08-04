import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';
class UserProfile extends StatelessWidget {
   final isFirend =  true ;
   const UserProfile({super.key});



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
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(

          child: Column(

            children: [
              Stack(
                  children: [
                    Image.asset("assets/images/cover.png",height: 200,width: double.infinity,fit: BoxFit.fitWidth,),
                    const SizedBox(height: 250,),
                    const Positioned(
                      left:0,
                      right:0,
                      bottom: 0,
                      child:  CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(  "assets/images/user.png"),
                      ),
                    ),

                  ]),
              const Text("Selfie verified",),
              Padding(padding: EdgeInsets.all(35),child: Column(
                children: [
                  const Row(
                    children: [
                      SizedBox(
                          height:40,
                          child: Text("Name",style:AppTextStyle.profilelabel )),Spacer(), Text("Ruppa sugan",style:AppTextStyle.ChatHeaderTextStyle )  ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height:40,
                    child: Row(
                      children: [
                        Text("Phone number",style:AppTextStyle.profilelabel ),Spacer(), Text("+91 9898989898",style:AppTextStyle.ChatHeaderTextStyle )  ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height:40,
                    child:  Row(
                      children: [
                        Text("Age",style:AppTextStyle.profilelabel ),Spacer(), Text("24",style:AppTextStyle.ChatHeaderTextStyle )  ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height:40,
                    child:  Row(
                      children: [
                        Text("Gender",style:AppTextStyle.profilelabel ),Spacer(), Text("Female",style:AppTextStyle.ChatHeaderTextStyle ) ],
                    ),
                  ),
                  Divider(),
                  const SizedBox(
                    height:40,
                    child:  Row(
                      children: [
                        Text("INTERESTS",style:AppTextStyle.profilelabel ),Spacer(),   ],


                    ),
                  ),
                  isFirend == true ?  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("  Remove  "),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.appSecondaryColor),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.appWhiteColor)/// Sonic blue color
                        ),),
                    ],

                  ) :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("  Accept  "),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.appSecondaryColor),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.appWhiteColor)/// Sonic blue color
                        ),),
                      SizedBox(width: 20,),
                      ElevatedButton(onPressed: (){}, child: Text("  Reject  "),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.appSecondaryColor),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.appWhiteColor)// Sonic blue color
                        ),)

                    ],

                  ),
                  const  SizedBox(height: 20,),
                  const Row(
                    children: [
                      Text("Verified : Selfie, Facebook",style:AppTextStyle.profilelabel,),
                    ],
                  )
                ],
              )
                ,),


            ],
          ),
        ),
      ),
    );
  }
}
