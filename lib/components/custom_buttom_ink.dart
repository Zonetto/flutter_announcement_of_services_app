import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonInk extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CustomButtonInk({
    super.key,
    required this.context,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(35),
      hoverColor: Colors.amber,
      onTap: onTap,
      child: Ink(
        width: Dimensions.screenWidth(context),
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ShapeDecoration(
          color: AppColor.screenBackGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          shadows: const [AppColor.shadow],
        ),
        child: Row(
          children: [
            CustomText(
              size: FontSize.buttonText,
              title: title,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            Container(
              width: (Dimensions.screenWidth(context) * 0.1) * 0.8,
              height: (Dimensions.screenWidth(context) * 0.1) * 0.8,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
                shape: const OvalBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
