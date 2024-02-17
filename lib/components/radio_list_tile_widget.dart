import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class RadioListTileWidget extends StatefulWidget {
  final String? selectedRadio;
  final void Function(String?)? onChanged;
  final List<String> lst;

  const RadioListTileWidget({
    super.key,
    this.selectedRadio,
    required this.lst,
    this.onChanged,
  });

  @override
  RadioListTileWidgetState createState() => RadioListTileWidgetState();
}

class RadioListTileWidgetState<T> extends State<RadioListTileWidget> {
  String? _selectedRadio;

  @override
  void initState() {
    super.initState();
    _selectedRadio = widget.selectedRadio;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.lst.length,
          (index) => RadioListTile<String>(
            dense: true,
            activeColor: AppColor.green,
            selectedTileColor: AppColor.buttonColorRed,
            title: TextWidget(title: widget.lst[index].toString()),
            value: index.toString(),
            groupValue: _selectedRadio,
            // onChanged: widget.onChanged
            onChanged: (String? value) {
              setState(() {
                _selectedRadio = value;
              });
              widget.onChanged?.call(value);
            },
          ),
        ),
      ),
    );
  }
}
