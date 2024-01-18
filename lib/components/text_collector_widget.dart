import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class TextCollectorWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isStar;
  const TextCollectorWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.isStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title: title,
            fontWeight: FontWeight.bold,
            size: FontSize.headline,
          ),
          Row(
            children: [
              isStar
                  ? const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                    )
                  : const SizedBox.shrink(),
              isStar ? const SizedBox(width: 4.0) : const SizedBox.shrink(),
              Expanded(
                child: TextWidget(
                  title: subTitle,
                  size: FontSize.plainText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
