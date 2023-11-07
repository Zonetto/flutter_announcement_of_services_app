import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight? fontWeight;
  final Color color;

  const CustomText({
    super.key,
    required this.title,
    required this.size,
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
        fontSize: size,
      ),
    );
  }
}
