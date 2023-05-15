import 'package:flutter/material.dart';
import 'package:todo/shared/styles/app_colors.dart';
import 'package:todo/shared/styles/text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.darkColor),
      scaffoldBackgroundColor: AppColor.lightGreenColor,
      primaryColor: AppColor.lightColor,
      brightness: Brightness.light,
      textTheme: TextTheme(
        bodyLarge: AppStyles.poppins22White(),
        bodyMedium: AppStyles.poppins18Light(),
        bodySmall: AppStyles.roboto12Black(),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.lightColor,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white, size: 30)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColor.lightColor,
      ));
  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColor.darkColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.darkBlueColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.darkColor),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.lightColor,
          centerTitle: false,
          iconTheme: IconThemeData(color: AppColor.darkColor, size: 30)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColor.lightColor,
      ),
      textTheme: TextTheme(
          bodyLarge: AppStyles.poppins22Dark(),
          bodyMedium: AppStyles.poppins18LightBlueDark(),
          bodySmall: AppStyles.roboto12White()));
}
