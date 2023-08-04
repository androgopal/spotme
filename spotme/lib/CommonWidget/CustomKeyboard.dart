import 'package:flutter/material.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomKeyboard({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appwhile50,
      // Define the layout and style of your custom keyboard
      child: Column(
        children: [
          buildRow(['1', '2', '3']),
          buildRow(['4', '5', '6']),
          buildRow(['7', '8', '9']),
          buildRow(['', '0', '<']),
        ],
      ),
    );
  }

  Widget buildRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys
            .map((key) => buildKeyButton(key))
            .toList(),
      ),
    );
  }

  Widget buildKeyButton(String key) {
    return Expanded(
      child: Container(
        // padding: const EdgeInsets.all(23.0),
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColor.appWhiteColor,

        ),
        child: MaterialButton(
           child: key == '<' ? Icon(Icons.backspace,color: Colors.black45,):Text(  key,  style:  TextStyle(fontSize:14 ,fontWeight:FontWeight.bold ,fontFamily: FontName.montserrat,)),
          onPressed: () => onKeyPressed(key),
        ),
      ),
    );
  }
}
