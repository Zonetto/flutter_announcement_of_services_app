import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;


Future<String> datePicker({required BuildContext context}) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2050),
  );

  if (date != null) {
    String formattedDate = intl.DateFormat('MM/dd/yyyy', 'en').format(date);
    return formattedDate;
  }
  return '';
}
