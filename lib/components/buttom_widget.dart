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
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool isLoad;
  const CustomButton({
    super.key,
    required this.context,
    required this.title,
    required this.onPressed,
    this.backGroundColor = AppColor.buttonColorGreen,
    this.textColor = AppColor.colorTextButtonWhite,
    this.width,
    this.height,
    this.isLoad = false,
  });

  @override
  Widget build(BuildContext context) {
    //  final double width = Dimensions.screenWidth(context);
    return SizedBox(
      width: width ?? Dimensions.screenWidth(context),
      height: height ?? 44,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backGroundColor,
          shape: const StadiumBorder(),
        ),
        child: isLoad
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    size: FontSize.buttonText,
                    title: 'أنتظر قليلاً',
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 20.0),
                  const CircularProgressIndicator(
                    color: AppColor.colorTextButtonWhite,
                  ),
                ],
              )
            : CustomText(
                size: FontSize.buttonText,
                title: title,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
      ),
    );
  }
}