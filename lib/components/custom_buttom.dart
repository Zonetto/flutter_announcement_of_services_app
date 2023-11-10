import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Color backGroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isSmall;

  const CustomButton({
    super.key,
    required this.context,
    required this.title,
    required this.onPressed,
    this.isSmall = false,
    this.backGroundColor = AppColor.buttonColorGreen,
    this.textColor = AppColor.colorTextButtonWhite,
  });

  @override
  Widget build(BuildContext context) {
    final double width = Dimensions.screenWidth(context);
    return SizedBox(
      width: isSmall ? width / 2 : width,
      height: 44,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backGroundColor,
          shape: const StadiumBorder(),
        ),
        child: CustomText(
          size: FontSize.buttonText,
          title: title,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
