import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:flutter/material.dart';

class CustomShapeDecoration {
  static ShapeDecoration shapeDecoration(BuildContext context,
          {Color? color}) =>
      ShapeDecoration(
        color: color ?? Theme.of(context).cardColor,
        // color: AppColor.screenBackGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [AppColor.shadow(context)],
      );
}
