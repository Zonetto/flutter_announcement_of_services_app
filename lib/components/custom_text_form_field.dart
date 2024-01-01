import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/typedef.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormFiled extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String headline;
  final String? hintText;
  final String? suffixText;
  final TextInputType textInputType;
  final ValidCallback? valid;
  final VoidCallback? onTab;
  final VoidCallback? onPressedPassword;
  final ValidCallback? onChanged;
  final Icon? icon;
  final int maxLines;
  final int? maxLength;
  final int minLines;
  final bool readOnly;
  final double? width;
  final bool isWithoutText;
  final bool isPassword;
  final bool obscureText;

  const CustomTextFormFiled({
    super.key,
    required this.context,
    required this.controller,
    required this.headline,
    this.hintText,
    this.suffixText,
    required this.textInputType,
    this.valid,
    this.onChanged,
    this.onTab,
    this.icon,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.width,
    this.isWithoutText = false,
    this.maxLength,
    this.isPassword = false,
    this.onPressedPassword,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Dimensions.screenWidth(context),
      padding: const EdgeInsets.only(bottom: 10.0),
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
            obscureText: obscureText,
            maxLength: maxLength,
            onChanged: onChanged,
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
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_outlined,
                      ),
                      onPressed: onPressedPassword,
                    )
                  : icon,
            ),
          ),
        ],
      ),
    );
  }
}
