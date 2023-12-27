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

Future<String> timePicker({
  required BuildContext context,
}) async {
  TimeOfDay currentTime = TimeOfDay.now();
  final TimeOfDay? time = await showTimePicker(
    initialEntryMode: TimePickerEntryMode.dialOnly,
    context: context,
    initialTime: currentTime,
  );
  if (time != null) {
    String formattedTime = convert12Hours(time);
    return formattedTime;
  }
  return '';
}


String convert12Hours(TimeOfDay time) {
  int hour = time.hour;
  int minute = time.minute;

  String period = (hour >= 12) ? 'مساءً' : 'صباحً';
  if (hour > 12) {
    hour = hour - 12;
  } else if (hour == 0) {
    hour = 12;
  }
  String convertedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';

  return convertedTime;
}
