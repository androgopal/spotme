

import 'package:flutter/material.dart';
import 'package:spotme/utils/color.dart';

class AppTextStyle{
  static const buttonTextStyle =  TextStyle(fontFamily: FontName.montserrat,fontSize: 14,fontWeight: FontWeight.bold,color: AppColor.appWhiteColor);
  static const headerTextStyle =  TextStyle(fontFamily: FontName.simplified,fontSize: 28,fontWeight: FontWeight.bold,color: AppColor.appBlackColor);
  static const ChatHeaderTextStyle =  TextStyle(fontFamily: FontName.simplified,fontSize: 14,fontWeight: FontWeight.bold,color: AppColor.appBlackColor);
  static const subHeaderTextStyle =  TextStyle(fontFamily: FontName.montserrat,fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.appBlackColor);
  static const profilelabel =  TextStyle(fontFamily: FontName.montserrat,fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.TextColorGray);
  static const drop_down =  TextStyle(fontFamily: FontName.montserrat,fontSize: 11,fontWeight: FontWeight.bold,color: AppColor.TextColorGray);
  static const buttonSpotMe =  TextStyle(fontFamily: FontName.montserrat,fontSize: 11,fontWeight: FontWeight.bold,color: AppColor.appSecondaryColor);

}




class FontName {
  static const String montserrat = "Montserrat";
  static const String simplified = 'HP Simplified Hans';

}



