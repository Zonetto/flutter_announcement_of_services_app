import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

import 'custom_image.dart';
import 'custom_text.dart';

class ComplexCard extends StatelessWidget {
  final String? backgroundImagePath;
  final String? profileImagePath;
  final VoidCallback? onTap;
  final VoidCallback? onPressedRejection;
  final VoidCallback? onPressedAccept;
  final VoidCallback? onPressedWait;
  final String name;
  final String star;
  final String price;
  final String title;
  final bool isAdmin;
  const ComplexCard({
    super.key,
    required this.backgroundImagePath,
    required this.profileImagePath,
    required this.name,
    required this.star,
    required this.price,
    required this.title,
    this.onTap,
    this.isAdmin = true,
    this.onPressedRejection,
    this.onPressedAccept,
    this.onPressedWait,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: AppColor.screenBackGroundColor,
          elevation: 10.0,
          // margin: const EdgeInsets.symmetric(vertical: 14.0),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: isAdmin ? 300 : 250,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImage(
                  imagePathNetwork: backgroundImagePath,
                  width: Dimensions.screenWidth(context),
                  height: 120,
                  radius: 15,
                ),
                Expanded(
                  child: ListTile(
                    title: CustomText(
                      title: title,
                      size: FontSize.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                            ),
                            CustomText(
                              title: star.toString(),
                              size: FontSize.plainText,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomImage(
                                imagePathNetwork: profileImagePath,
                                height: AppSize.imageSizeSmall(context),
                                width: AppSize.imageSizeSmall(context),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: name,
                                        size: FontSize.plainText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const CustomText(
                                        title: 'متوفر',
                                        size: FontSize.plainText,
                                        color: AppColor.colorTextButtonGreen,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: isAdmin
                        ? const SizedBox.shrink()
                        : Container(
                            width: Dimensions.screenWidth(context) * 0.2,
                            height: 25,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF539165),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            child: Center(
                              child: CustomText(
                                title: '$price ألف',
                                color: AppColor.colorTextButtonWhite,
                                size: FontSize.plainText,
                              ),
                            ),
                          ),
                  ),
                ),
                isAdmin
                    ? Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              context: context,
                              title: 'قبول',
                              onPressed: onPressedAccept,
                              width: Dimensions.screenWidth(context) / 2,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              context: context,
                              backGroundColor: AppColor.buttonColorRed,
                              title: 'رفض',
                              onPressed: onPressedRejection,
                              width: Dimensions.screenWidth(context) / 2,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              context: context,
                              backGroundColor: Colors.blueAccent.withOpacity(0.8),
                              title: 'إنتظار',
                              onPressed: onPressedWait,
                              width: Dimensions.screenWidth(context) / 2,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
