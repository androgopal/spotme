import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/HttpServices/HttpService.dart';
import 'package:spotme/Screens/Chats/ChatScreen.dart';
import 'package:spotme/Screens/Map/MapNearMe.dart';
import 'package:spotme/Screens/NearMeFriend/NearMeFriend.dart';
import 'package:spotme/Screens/UserProfile/Bloc/profile_bloc.dart';
import 'package:spotme/Screens/UserProfile/Bloc/profile_state.dart';
import 'package:spotme/Screens/UserProfile/EditProfile.dart';
import 'package:spotme/Screens/UserProfile/UserProfile.dart';
import 'package:spotme/Screens/UserProfile/models/profile_model.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/ToastMessage.dart';
import 'package:spotme/utils/color.dart';

class ChatUserList extends StatelessWidget {
  const ChatUserList({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Perform action when back button is pressed
            Navigator.pop(context);
          },
        ),
        actions: [
          BlocProvider(
            create: (_) => ProfileBloc(ApiService.shared),
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // var model =  ApiService.shared.readUserData();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      BlocProvider(
                        create: (context) => ProfileBloc(ApiService.shared)..fetchProfileDetails(null),
                        child: EditProfile(),
                      )),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.spotMeBoard,
                style: TextStyle(
                    fontSize: 39,
                    fontFamily: FontName.simplified,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grayColor),
              ),
              Expanded(
                  child: ListView.separated(
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          if (index != 5) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile()),
                            );
                          }
                        },
                        leading: const SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: CircleAvatar(
                              foregroundImage: AssetImage(
                                "assets/images/user.png",
                              ),
                            )),
                        title: const Text(
                          "Siva Gurnathan",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColor.appSecondaryColor,
                              fontFamily: FontName.montserrat),
                        ),
                        subtitle: (index != 5)
                            ? const Text("Be friends",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.appRecieverChatColor,
                            ))
                            : SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              const Text("New ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.grayColor2,
                                  )),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  // Button onPressed code here
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => NearMeFriendList()),
                                  // );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(AppColor
                                      .grayColor2), // Sonic blue color
                                ),
                                child: const Text(
                                  'Accept',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.TextColorGray,
                                      fontFamily: FontName.montserrat),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Button onPressed code here
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => MapNearMe()),
                                  // );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(AppColor
                                      .grayColor2), // Sonic blue color
                                ),
                                child: const Text(
                                  'Reject',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.TextColorGray,
                                      fontFamily: FontName.montserrat),
                                ),
                              )
                            ],
                          ),
                        ),
                        trailing: index != 5
                            ? Column(
                          children: [
                            const Text("20:19",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.TextColorGray,
                                    fontFamily: FontName.montserrat)),
                            Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor.appSecondaryColor,
                                ),
                                child: const Text(
                                  "2",
                                  style: TextStyle(
                                      color: AppColor.appWhiteColor),
                                )),
                          ],
                        )
                            : null,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: AppColor.AppBorderColor,
                        indent: 70,
                      );
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Button onPressed code here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NearMeFriendList()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.appSecondaryColor), // Sonic blue color
                    ),
                    child: const Text(
                      '  Friend  ',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColor.appWhiteColor,
                          fontFamily: FontName.montserrat),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Button onPressed code here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapNearMe()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.appSecondaryColor), // Sonic blue color
                    ),
                    child: const Text(
                      'Spot New',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColor.appWhiteColor,
                          fontFamily: FontName.montserrat),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
