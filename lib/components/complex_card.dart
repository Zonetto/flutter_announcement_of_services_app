import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class ComplexCard extends StatelessWidget {
  final String backgroundImagePath;
  final String profileImagePath;
  final String name;
  final double star;
  final int price;
  final String title;
  const ComplexCard({
    super.key,
    required this.backgroundImagePath,
    required this.profileImagePath,
    required this.name,
    required this.star,
    required this.price,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Card(
            color: AppColor.screenBackGroundColor,
            elevation: 10.0,
            // margin: const EdgeInsets.symmetric(vertical: 14.0),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: Dimensions.screenWidth(context),
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        backgroundImagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                ListTile(
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
                            Container(
                              width: Dimensions.screenWidth(context) * 0.11,
                              height: Dimensions.screenWidth(context) * 0.11,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    profileImagePath,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                shape: const OvalBorder(),
                                shadows: [AppColor.shadow],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                    ],
                  ),
                  trailing: Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
