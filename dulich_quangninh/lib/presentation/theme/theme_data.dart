import 'package:flutter/material.dart';
import 'theme_color.dart';
import 'theme_dialog.dart';
import 'theme_icons.dart';
import 'theme_input_decoration.dart';
import 'theme_snackbar.dart';
import 'theme_text.dart';

// These are sample values can be changed to have a more generic data.
// We are going to extend the theme for the relevant pages

ThemeData appTheme(BuildContext context) {
//  ScreenUtil.init(context, width: 375, height: 812);
  return ThemeData(
      fontFamily: 'SF Pro',
      primaryColor: AppColor.primaryColor,
      textTheme: ThemeText.getDefaultTextTheme(),
      buttonTheme: ButtonThemeData(
        //update and enhance in screens where necessary
        buttonColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      scaffoldBackgroundColor: AppColor.white,
      iconTheme: ThemeIcon.getDefaultIconTheme(),
      appBarTheme: const AppBarTheme(color: AppColor.primaryColor, elevation: 0.0),
      dialogTheme: ThemeDialog.getDefaultDialogTheme(),
      snackBarTheme: ThemeSnackBar.getDefaultSnackBarTheme(),
      inputDecorationTheme: ThemeInputDecoration.get(context),
      toggleableActiveColor: AppColor.primaryColor,
      cursorColor: AppColor.primaryColor);
}
