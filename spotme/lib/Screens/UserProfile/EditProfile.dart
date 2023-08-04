
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/HttpServices/HttpService.dart';
import 'package:spotme/Screens/LandingPage/LandingPage.dart';
import 'package:spotme/Screens/UserProfile/Bloc/profile_bloc.dart';
import 'package:spotme/Screens/UserProfile/Bloc/profile_state.dart';
import 'package:spotme/Screens/UserProfile/models/profile_model.dart';
import 'package:spotme/Screens/common_widget/custom_textfield.dart';
import 'package:spotme/utils/LocalImages.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';

class EditProfile extends StatelessWidget {
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
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (bloc, state) {
          print("State is called with state ${state}");

          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProfileErrorState) {
            return Center(child: Text(state.message));
          }
          if (state is ProfileDetails) {
           ProfileModel? userDetails  = state.userDetails;
            return SafeArea(
                  child:  ListView(
                    scrollDirection : Axis.vertical,
                    children: [
                      SizedBox(
                        height: 250,
                        child:    Stack(children: [
                          Image.asset(
                            "assets/images/cover.png",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        const  SizedBox(
                            height: 250,
                          ),
                     const     Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage("assets/images/user.png"),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                LocalImages.blueCamera,
                                height: 40,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            right: 0,
                            bottom: -5,
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                LocalImages.blueCamera,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const  Text(
                                  "Name",
                                  style: AppTextStyle.profilelabel,
                                ),
                                Spacer(),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: userDetails?.name ?? "",
                                    style: const TextStyle(
                                        color: AppColor.appPrimary1Color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    onChanged: (value){
                                      userDetails?.name =  value.trim();
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration:  InputDecoration(
                                      hintText:   'Enter text here...',
                                      // border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const  Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const  Text("Phone number",
                                    style: AppTextStyle.profilelabel),
                                const   Spacer(),
                                Text(
                                  userDetails?.phone ?? "",
                                )
                              ],
                            ),
                            const Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Text("Age", style: AppTextStyle.profilelabel),
                                const   Spacer(),
                                Expanded(
                                  child: TextFormField(
                                    initialValue:userDetails?.dob ?? "",
                                    style: const TextStyle(
                                        color: AppColor.appPrimary1Color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    onChanged: (value){
                                      userDetails?.dob =  value.trim();

                                    },
                                    keyboardType: TextInputType.text,
                                    decoration:  InputDecoration(
                                      hintText:   'Enter text here...',
                                      // border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const    Text("Gender", style: AppTextStyle.profilelabel),
                                const    Spacer(),
                                Expanded(
                                  child: TextFormField(
                                    initialValue:userDetails?.gender ?? "",
                                    style: const TextStyle(
                                        color: AppColor.appPrimary1Color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    onChanged: (value){
                                      userDetails?.gender =  value.trim();

                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText:   'Enter text here...',
                                      // border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Text("Discover Me",
                                    style: AppTextStyle.profilelabel),
                                const   Spacer(),
                                Switch(value: userDetails?.discoverme ?? false, onChanged: (value){
                                  userDetails?.discoverme =  value;

                                }),
                              ],
                            ),
                            const   Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const   Text("Instagram", style: AppTextStyle.profilelabel),
                                const  Spacer(),
                                Text(
                                  ( userDetails?.instagramVerify ?? false) ? "Verified":"Verify Now",
                                )
                              ],
                            ),
                            const  Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const    Text("Facebook", style: AppTextStyle.profilelabel),
                                const   Spacer(),
                                Text(
                                  ( userDetails?.instagramVerify ?? false) ? "Verified":"Verify Now",
                                )
                              ],
                            ),
                            const   Divider(
                              color: AppColor.appwhile50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                const    Text("INTERESTS", style: AppTextStyle.profilelabel),
                                const    Spacer(),

                                Expanded(
                                  child: TextFormField(
                                    initialValue:userDetails?.interest ?? "",
                                    style: const TextStyle(
                                        color: AppColor.appPrimary1Color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    onChanged: (value){

                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText:   'Enter text here...',
                                      // border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(onPressed: (){
                              ApiService.shared.updateUser(userDetails!);
                            }, child:const Text("SAVE")),

                            TextButton(onPressed: (){
                              ApiService.shared.logoutUser();
                              Navigator.of(context).pushNamed(LandingScreen.id);
                            }, child:const Text("Logout")),
                          ],
                        ),
                      ),
                    ],
                  )


            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

