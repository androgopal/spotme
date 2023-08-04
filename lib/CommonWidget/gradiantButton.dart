import 'package:flutter/material.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';


class GradientButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.appPrimary1Color, AppColor.appPrimaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: MaterialButton(
        onPressed: () => onPressed(),
        child: Text(
          text,
          style:AppTextStyle.buttonTextStyle,

        ),
      ),
    );
  }
}
