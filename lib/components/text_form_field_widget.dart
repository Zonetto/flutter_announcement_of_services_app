import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/typedef.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class TextFormFieldWidget extends StatelessWidget {
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
  final double? borderSideWidth;
  final InputBorder? enabledBorder;
  final bool readOnly;
  final double? width;
  final bool isWithoutText;
  final bool isPassword;
  final bool obscureText;

  const TextFormFieldWidget({
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
    this.borderSideWidth = 1,
    this.enabledBorder,
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
      padding: const EdgeInsets.only(bottom: 13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !isWithoutText
              ? TextWidget(
                  title: headline,
                  size: FontSize.subtitle(context),
                  fontWeight: FontWeight.w600,
                )
              : const SizedBox.shrink(),
          !isWithoutText
              ? const SizedBox(
                  height: 10.0,
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
                borderSide: BorderSide(
                  color: AppColor.green,
                  width: borderSideWidth!,
                ),
              ),
              enabledBorder: enabledBorder,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Cairo",
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              suffixIconColor: Theme.of(context).iconTheme.color,
              filled: true,
              fillColor: Theme.of(context).secondaryHeaderColor,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_outlined,
                        color: Theme.of(context).iconTheme.color,
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
