import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> fillDropdownItems(List<String> items) {
  return items.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }).toList();
}
