import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight? fontWeight;
  final Color color;

  const CustomText({
    super.key,
    required this.title,
    this.size = 18,
    this.fontWeight,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: Dimensions.fontSize(context, size),
      ),
    );
  }
}
