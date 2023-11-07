import 'package:flutter/material.dart';

Future<void> navigatePushScreen({
  required BuildContext context,
  Widget? screen,
}) async {
  // final route = MaterialPageRoute(builder: (context) => screen!);
  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => screen!,
  ));
}
