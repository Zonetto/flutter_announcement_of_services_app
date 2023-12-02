import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:flutter/material.dart';

class CustomShapeDecoration {
  static ShapeDecoration shapeDecoration = ShapeDecoration(
    color: AppColor.screenBackGroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    shadows: const [AppColor.shadow],
  );
}