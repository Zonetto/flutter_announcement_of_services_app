import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double size;
  final TextAlign alignment;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextWidget({
    super.key,
    required this.title,
    this.size = 18,
    this.fontWeight,
    this.color ,
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
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: Dimensions.fontSize(context, size),
      ),
    );
  }
}
