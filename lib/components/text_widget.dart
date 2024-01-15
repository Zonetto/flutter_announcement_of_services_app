import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double size;
  final TextAlign alignment;
  final FontWeight? fontWeight;
  final Color color;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.title,
    this.size = 18,
    this.fontWeight,
    this.color = AppColor.colorTextBlack,
    this.alignment = TextAlign.right,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: alignment,
      overflow: overflow,
      title,
      maxLines: maxLines,
      //  style: Theme.of(context).textTheme.titleLarge,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: Dimensions.fontSize(context, size),
      ),
    );
  }
}
