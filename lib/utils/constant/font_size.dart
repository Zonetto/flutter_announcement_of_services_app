import 'package:flutter/material.dart';

class FontSize {
  static double headline(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.fontSize! + 2;
  static double subtitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.fontSize! + 2;
  static double plainText(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.fontSize!;
  static double buttonText(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.fontSize!;
}
