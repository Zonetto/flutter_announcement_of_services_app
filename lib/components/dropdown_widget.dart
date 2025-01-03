import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/typedef.dart';
import 'package:flutter/material.dart';

class DropdownStringWidget extends StatelessWidget {
  final BuildContext context;
  final ValidCallback onChanged;
  final ValidCallback? valid;
  final String? value;
  final String? hintText;
  final String? suffixText;
  final List<DropdownMenuItem<String>> items;
  final double? width;
  final bool disabled;
  const DropdownStringWidget({
    super.key,
    required this.context,
    required this.onChanged,
    this.value,
    required this.items,
    this.width,
    this.hintText,
    this.suffixText,
    this.valid,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = Dimensions.screenWidth(context);
    return SizedBox(
      width: width ?? mediaQueryWidth,
      child: SizedBox(
        child: DropdownButtonFormField(
          validator: valid,
          menuMaxHeight: 200,

          elevation: 0,
          padding: const EdgeInsets.only(bottom: 14.0),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            suffixText: suffixText,
            suffixIconColor: Theme.of(context).iconTheme.color,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.green, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            fillColor: Theme.of(context).secondaryHeaderColor,
          ),
          dropdownColor: Theme.of(context).secondaryHeaderColor,
          value: value,
          // disabledHint: Text("asdsada"),
          onChanged: disabled ? null : onChanged,
          items: items,
        ),
      ),
    );
  }
}
