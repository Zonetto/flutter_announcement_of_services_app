import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:flutter/material.dart';

Future<void> alertDialog({
  String? title,
  required String content,
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
        // content: Text(
        //   content,

        // ),
        content: TextWidget(title: content, size: FontSize.plainText(context)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextWidget(title: 'لا', size: FontSize.plainText(context)),
          ),
          TextButton(
            onPressed: onPressed,
            child: TextWidget(title: 'نعم', size: FontSize.plainText(context)),
          ),
        ],
      );
    },
  );
}
