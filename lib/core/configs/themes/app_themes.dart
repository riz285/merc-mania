import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

class AppTheme {
  //Light mode
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      brightness: Brightness.light,
      //Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));

  //Dark mode
  static final darkTheme = ThemeData(
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: AppColors.darkBackground,
      brightness: Brightness.dark,
      //Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[900],
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));
}
