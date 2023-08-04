import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/CommonWidget/CustomKeyboard.dart';
import 'package:spotme/CommonWidget/gradiantButton.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authBloc.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authState.dart';
import 'package:spotme/Screens/MobileLogin/OtpVerification.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/ToastMessage.dart';
import 'package:spotme/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileLogin extends StatefulWidget {

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final TextEditingController _textEditingController = TextEditingController();
  var phoneNumber = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.appWhiteColor,
          // padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 120,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                Strings.enterYourPhoneNumber, textAlign: TextAlign.center,
                style: TextStyle(fontFamily: FontName.montserrat,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  maxLines: 1,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  readOnly: true,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: Strings.phonenumber,
                    prefixIcon: SizedBox(
                      height: 10.0,
                      width: 10.0,
                      child: Image.asset(
                        "assets/images/mobile.png",
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              BlocConsumer<AuthCubit,AuthState>(
                listener:  (context,state)
          {
            if (state is AuthCodeSentState){
              Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => OTPVerification()));
            }
            if (state is AuthErrorState){
              ToastMessage.showSnackbar(context,state.error,false);
            }
          }    ,
                builder: (context,state){
                  if (state! is AuthLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return   Padding(
                      padding: const EdgeInsets.all(30.0),
                    child: GradientButton(
                      onPressed: () {
                        String phonenumber = this.phoneNumber;
                        BlocProvider.of<AuthCubit>(context).sendOTP(phonenumber);
                      },
                      text: Strings.continueText,
                    ),
                  );
                },
              ),

              const Spacer(),
              CustomKeyboard(
                onKeyPressed: (value) {
                  if ("<" == value) {
                    String modifiedString = phoneNumber
                        .substring(0, phoneNumber.length - 1);
                    phoneNumber = modifiedString;
                    _textEditingController.text = phoneNumber;
                  } else {
                    if (phoneNumber.length < 10) {
                      phoneNumber += value;
                      _textEditingController.text = phoneNumber;
                      print(phoneNumber);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
