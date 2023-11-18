import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/typedef.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormFiled extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String headline;
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
  final bool isWithoutText;

  const CustomTextFormFiled({
    super.key,
    required this.context,
    required this.controller,
    required this.headline,
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
    this.isWithoutText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !isWithoutText
              ? CustomText(
                  title: headline,
                  size: FontSize.subtitle,
                  fontWeight: FontWeight.w600,
                )
              : const SizedBox.shrink(),
          !isWithoutText
              ? const SizedBox(
                  height: 4.0,
                )
              : const SizedBox.shrink(),
          TextFormField(
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
        ],
      ),
    );
  }
}
