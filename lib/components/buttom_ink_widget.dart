import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomButtonInk extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String? imagePath;
  final VoidCallback onTap;
  final bool isImage;
  final IconData? icon;

  const CustomButtonInk({
    super.key,
    required this.context,
    required this.title,
    this.imagePath,
    required this.onTap,
    this.isImage = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(35),
        onTap: onTap,
        child: Ink(
          width: Dimensions.screenWidth(context),
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              isImage
                  ? Container(
                      width: (Dimensions.screenWidth(context) * 0.1) * 0.8,
                      height: (Dimensions.screenWidth(context) * 0.1) * 0.8,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            imagePath!,
                          ),
                          fit: BoxFit.cover,
                        ),
                        shape: const OvalBorder(),
                      ),
                    )
                  : Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}
