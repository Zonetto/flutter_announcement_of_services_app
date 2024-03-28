import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

Future<void> alertDialog({
  String? title,
  Widget? widget,
  String? content,
  String? acceptedTitle,
  required BuildContext context,
  required onPressed,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: title != null
            ? TextWidget(title: title, size: FontSize.headline(context))
            : null,
        content: widget ??
            TextWidget(title: content ?? '', size: FontSize.plainText(context)),
        actions: [
          Row(children: [
            ButtonWidget(
              context: context,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'الغاء',
              backGroundColor: AppColor.buttonColorRed,
              width: Dimensions.screenWidth(context) / 3.5,
            ),
            const SizedBox(width: 10.0),
            ButtonWidget(
              context: context,
              onPressed: onPressed,
              title: acceptedTitle ?? 'نعم',
              backGroundColor: AppColor.green,
              width: Dimensions.screenWidth(context) / 3.5,
            ),
          ]),
        ],
      );
    },
  );
}
