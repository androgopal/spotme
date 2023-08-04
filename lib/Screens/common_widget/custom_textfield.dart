import 'package:flutter/material.dart';
import 'package:spotme/utils/color.dart';

class CustomTextfield extends StatelessWidget {
 final bool readOnly = false;
 final TextAlign textAlign = TextAlign.start;
 final int maxLength = 40;
 final Function(String) onChanged;
 final TextInputType keyboardType;
 final InputDecoration? inputDecoration;
 final String? text;
 final String? hintText;

 const CustomTextfield({super.key,required this.onChanged, required this.keyboardType, this.inputDecoration, this.text, this.hintText});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextFormField(
        initialValue: text,
        readOnly: readOnly ?? false,
        style: const TextStyle(
            color: AppColor.appBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
        maxLines: 1,
        maxLength: maxLength ?? 40,
        onChanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: inputDecoration ??
            InputDecoration(
              hintText: hintText ?? 'Enter text here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none, // Remove the underline
              ),
            )
      ),
    );
  }
}
