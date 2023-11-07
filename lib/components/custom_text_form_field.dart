import 'package:announcement_of_services/utils/typedef.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String hintText;
  final String? suffixText;
  final TextInputType textInputType;
  final ValidCallback valid;
  final VoidCallback? onTab;
  final Icon icon;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final double width;

  const CustomTextFormFiled({
    super.key,
    required this.context,
    required this.controller,
    required this.hintText,
    this.suffixText,
    required this.textInputType,
    required this.valid,
    this.onTab,
    required this.icon,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.width = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: mediaQueryWidth * width,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        validator: valid,
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        readOnly: readOnly,
        keyboardType: textInputType,
        onTap: onTab,
        decoration: InputDecoration(
          suffixText: suffixText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.green, width: 1),
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFFD7D9E0),
          suffixIcon: icon,
        ),
      ),
    );
  }
}
