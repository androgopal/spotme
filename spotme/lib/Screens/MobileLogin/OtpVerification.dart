import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/CommonWidget/CustomKeyboard.dart';
import 'package:spotme/HttpServices/HttpService.dart';
import 'package:spotme/Screens/Chats/ChaUserList.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authBloc.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authState.dart';
import 'package:spotme/Screens/UserProfile/EditProfile.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/ToastMessage.dart';
import 'package:spotme/utils/color.dart';


// class OTPVerification extends StatefulWidget {
//   const OTPVerification({super.key});
//
//   @override
//   State<OTPVerification> createState() => _OTPVerificationState();
// }
class OTPVerification extends StatelessWidget {
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            Strings.enterOtp,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontFamily: FontName.montserrat),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i < 7; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: i <= otp.text.length
                        ? Color(0xFF6478D3) : Color(0x2F6478D3),
                  ),
                ),
            ],
          ),
          BlocConsumer<AuthCubit,AuthState>(
            listener: (BuildContext context, Object? state) {
              if (state is AuthLoggedInState){
                if (ApiService.shared.readUserData(null) == null){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (
                          BuildContext context) =>  EditProfile()));
                }
                else {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (
                          BuildContext context) => const ChatUserList()));
                }
              }else {
               if (state is AuthErrorState){
                 Navigator.pop(context);
               }
              }

            },
            builder: (BuildContext context, state) {
              if (state! is AuthLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (state is AuthErrorState) {
                return ToastMessage.show(state.error);
              }

           return   TextButton(
                  onPressed: () {
                    if (otp.text.length < 6) {
                      ToastMessage.show(Strings.emptyOTP);
                    } else {
                  BlocProvider.of<AuthCubit>(context).verifyOTP(otp.text);
                    }
                  },
                  child: const Text(
                    Strings.resendOtp,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontName.montserrat,
                        color: AppColor.appSecondary1Color),
                  )
              );
            },

          ),
          CustomKeyboard(
            onKeyPressed: (value) {

                if ("<" == value) {
                  String modifiedString =
                      otp.text.substring(0, otp.text.length - 1);
                  otp.text = modifiedString;
                  otp.text = otp.text;
                } else {
                  if (otp.text.length < 6) {
                    otp.text += value;
                    print(otp.text);
                  }
                }
              }
            ),

        ],
      ),
    );
  }
}
