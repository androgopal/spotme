import 'package:flutter/material.dart';
import 'package:spotme/Screens/Chats/ChaUserList.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';

class ShowDailog extends StatelessWidget {
  const ShowDailog({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
         child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30,),
                CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColor.appGreenColor,
                    child: Image.asset('assets/images/success.png',height: 40,width: 40,)),
                const SizedBox(height: 16.0),
                const Text(
                  'Request sent',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,fontFamily: FontName.montserrat),
                ),
                const SizedBox(height: 8.0),
                const Text('Request sent to all of them, once they accept you can see in your spotme board ',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,fontFamily: FontName.montserrat,color: AppColor.TextColorGray),),
                const SizedBox(height: 20,),
                const Divider(height: 2,color: AppColor.appwhile50,)
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatUserList()),
                  );
                },
                child: const Text('SpotMe Board',style: AppTextStyle.buttonSpotMe,),
              ),
                ]
            ),
          ],
        ),
      ),
    );
  }


}
