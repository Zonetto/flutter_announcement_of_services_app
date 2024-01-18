import 'package:flutter/material.dart';

Future<void> navigateToScreen({
  required BuildContext context,
  required Widget screen,
}) async {
  // final route = MaterialPageRoute(builder: (context) => screen!);
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

Future<void> navigateAndReplaceScreen({
  required BuildContext context,
  required Widget screen,
}) async {
  await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => false,
  );
}


// Future<void> navigateAndReplaceScreen({
//   required BuildContext context,
//   required String routeName,
// }) async {
//   await Navigator.pushReplacementNamed(context, routeName);
// }


// Future<void> navigateToNamedScreen({
//   required BuildContext context,
//   required String routeName,
// }) async {
//   await Navigator.pushNamed(context, routeName);
// }




// Future<void> navigateToNamedScreen1({
//   required BuildContext context,
//   // required Widget screen,
//   required String routeName,
// }) async {
//   await Navigator.pushReplacementNamed(context, routeName);
//   // await Navigator.of(context).push(MaterialPageRoute(
//   //   builder: (context) => screen,
//   // )));
// }
