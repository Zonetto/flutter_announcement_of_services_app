import 'package:announcement_of_services/components/custom_text.dart';
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
        title: title != null ? Text(title) : null,
        content: Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const CustomText(title: 'لا', size: FontSize.plainText),
          ),
          TextButton(
            onPressed: onPressed,
            child: const CustomText(title: 'نعم', size: FontSize.plainText),
          ),
        ],
      );
    },
  );
}
