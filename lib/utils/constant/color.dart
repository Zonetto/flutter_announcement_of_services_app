import 'package:flutter/material.dart';

class AppColor {
  static const Color colorTextBlack = Colors.black;
  static  Color buttonColorRed = Colors.red.withOpacity(0.8);
  static const Color screenBackGroundColor = Color(0xFFF0F5F2);
  static const Color buttonColorGreen = Color(0xFF539165);
  static const Color buttonColorGrey = Color(0xFFD9D9D9);
  static const Color colorTextButtonWhite = Colors.white;
  static const Color colorTextButtonGreen = Color(0xFF539165);
  static const Color shadowColor = Color(0x3F000000);
  static const BoxShadow shadow = BoxShadow(
    color: AppColor.shadowColor,
    blurRadius: 4,
    offset: Offset(0, 4),
    spreadRadius: 0,
  );
}
