import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFD9D9D9);
  static const Color green = Color(0xFF539165);
  static const Color shadeOfGreen = Color(0xFF539165);
  static const Color lightShade = Color(0xFFF0F5F2);
  static const Color darkShade = Color(0x011A1A1A);
  static Color darkShadeText = const Color(0x011A1A1A).withOpacity(0.9);
  static Color whiteText = Colors.white.withOpacity(0.9);

  static const Color colorTextBlack = Colors.black;
  static Color buttonColorRed = Colors.red.withOpacity(0.8);
  static const Color shadowColor = Color(0x3F000000);
  static BoxShadow shadow(BuildContext context) => const BoxShadow(
        //? light shadowColor //? dark darkShadeText
        color: AppColor.shadowColor,
        blurRadius: 4,
        offset: Offset(0, 2),
        spreadRadius: 0,
      );
}
