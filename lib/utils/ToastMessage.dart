

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastMessage{
 static show(String msg){
   Fluttertoast.showToast(
       msg: msg,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 3,
       backgroundColor: Colors.red,
       textColor: Colors.white,
       fontSize: 16.0
   );
 }
 static void showSnackbar(BuildContext context, String message, bool isGreen) {
   final snackbar = SnackBar(
     content: Text(message),
     backgroundColor: isGreen ? Colors.green : Colors.red, // Set background color based on condition
     duration: const Duration(seconds: 3),
   );

   ScaffoldMessenger.of(context).showSnackBar(snackbar);
 }
}