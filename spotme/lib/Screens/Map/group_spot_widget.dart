import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:spotme/utils/LocalImages.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';

class GroupSpotWidget extends StatelessWidget {
  final double width;

  GroupSpotWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child:  Image.asset(LocalImages.user,width: width,),),
        SizedBox(width:15 ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Spot Near ",
                  style:  TextStyle(fontFamily: FontName.simplified,fontSize: 11,fontWeight: FontWeight.bold,color: AppColor.appSecondaryColor),
                ),
                const Text(
                  "10",
                  style:  TextStyle(fontFamily: FontName.simplified,fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.appSecondaryColor),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    
                  },
                  child: Image.asset(LocalImages.add,width: 30,),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset(LocalImages.minus,width: 30,),
                )

              ],
            ),
            const Text("MSG to them. ",
            style:  TextStyle(fontFamily: FontName.simplified,fontSize: 14,fontWeight: FontWeight.bold,color: AppColor.grayColor),
    )
          ],
        )
      ],
    );
  }
}
