import 'package:flutter/material.dart';

import 'responsive_screen.dart';

class AppSize {
  static const EdgeInsets nternalMargin = EdgeInsets.symmetric(
    horizontal: 10.0,
    vertical: 10.0,
  );
  static const EdgeInsets padding = EdgeInsets.symmetric(
    horizontal: 10.0,
    // vertical: 20.0,
  );
  static const SizedBox sizedBoxHeight = SizedBox(
    height: 10,
  );

  static double imageSizeSmall(BuildContext context) =>
      Dimensions.screenWidth(context) / 9.0;
  static double imageSizeLarge(BuildContext context) =>
      Dimensions.screenWidth(context) / 3.0;

//  static const double internalMargin = 20.0;
}
