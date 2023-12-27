import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    styledScaffoldMessenger({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.up,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      content: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ));
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
