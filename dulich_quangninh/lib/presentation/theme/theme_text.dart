import 'package:flutter/material.dart';

import 'theme_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//w100 Thin, the least thick
//w200 Extra-light
//w300 Light
//w400 Normal / regular / plain
//w500 Medium
//w600 Semi-bold
//w700 Bold
//w800 Extra-bold
//w900 Black, the most thick

// All text style based on design guideline

class ThemeText {
  // Default Text Style Following Guideline

  static TextTheme getDefaultTextTheme() => TextTheme(
      display4: TextStyle(
          fontSize: 38.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor),
      display3: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor),
      display2: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor),
      display1: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor),
      headline: TextStyle(
          fontSize: 44.0.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor),
      title: TextStyle(
          fontSize: 27.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor),
      body1: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor),
      body2: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      subhead: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal),
      caption: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor,
          letterSpacing: -0.3),
      overline: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          color: AppColor.iconColorGrey),
      subtitle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.textColor),
      button: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.white));
}

extension CustomTextTheme on TextTheme {
  TextStyle get buttonTextStyle => TextStyle(
      fontSize: 18.sp,
      color: AppColor.white,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.4);

  TextStyle get captionSemiBold => TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColor.textColor);

  TextStyle get textLabelItem => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.textColor,
      letterSpacing: -0.3);

  TextStyle get textTitleItem => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.textColor,
      letterSpacing: -0.3);

  TextStyle get textHint => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.textHintColor,
      letterSpacing: -0.3);

  TextStyle get textMenu => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.textColor,
      letterSpacing: -0.3);

  TextStyle get subTextMenu => TextStyle(
      fontSize: 9.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.textCaptionColor,
      letterSpacing: -0.18);

  TextStyle get textMoneyMenu => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.textColor,
      letterSpacing: -0.3);

  TextStyle get textTotalMoneyChart => TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.textColor,
      letterSpacing: -0.4);

  TextStyle get textErrorField => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.normal,
      color: AppColor.textError);

  TextStyle get hint => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.textHintColor,
      letterSpacing: -0.3);

  TextStyle get textField => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.textColor,
      letterSpacing: -0.3);

  TextStyle get textDateRange => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
      );

  TextStyle get textLabelChart => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.textChartGrey
  );
}
