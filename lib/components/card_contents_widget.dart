import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';
import 'buttom_widget.dart';
import 'image_widget.dart';
import 'text_widget.dart';

class CardContents extends StatelessWidget {
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
  const CardContents({
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // color: AppColor.screenBackGroundColor,
        color: Theme.of(context).cardColor,
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
              ImageWidget1(
                imagePathNetwork: backgroundImagePath,
              ),
              Expanded(
                child: ListTile(
                  title: TextWidget(
                    title: title,
                    size: FontSize.subtitle(context),
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
                          TextWidget(
                            title: star.toString(),
                            size: FontSize.plainText(context),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageWidget(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      title: name,
                                      size: FontSize.plainText(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextWidget(
                                      title: 'متوفر',
                                      size: FontSize.plainText(context),
                                      color: AppColor.shadeOfGreen,
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
                            child: TextWidget(
                              title: '$price ألف',
                              color: AppColor.white,
                              size: FontSize.plainText(context),
                            ),
                          ),
                        ),
                ),
              ),
              isAdmin
                  ? Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            context: context,
                            title: 'قبول',
                            onPressed: onPressedAccept,
                            width: Dimensions.screenWidth(context) / 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ButtonWidget(
                            context: context,
                            backGroundColor: AppColor.buttonColorRed,
                            title: 'رفض',
                            onPressed: onPressedRejection,
                            width: Dimensions.screenWidth(context) / 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ButtonWidget(
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
    );
  }
}
