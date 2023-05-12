import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/styles/app_colors.dart';

class AppStyles {
  static TextStyle poppins22White() => GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle poppins22Dark() => GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.darkColor);

  static TextStyle poppins18Light() => GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.lightColor);

  static TextStyle poppins18LightBlueDark() => GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.darkColor);

  static TextStyle roboto12Black() => GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black45);

  static TextStyle roboto12White() => GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white);
}
