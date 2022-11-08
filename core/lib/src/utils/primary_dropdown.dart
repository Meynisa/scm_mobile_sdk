import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DropdownViewModel extends StatelessWidget {
  String? value;
  Function(String?)? onChanged;
  List<String>? items;

  DropdownViewModel({this.value, this.onChanged, this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      icon: Icon(Icons.arrow_drop_down),
      elevation: 16,
      onChanged: (String? newValue) => onChanged!(newValue),
      items: items!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            child: Text(value, style: body1()), value: value);
      }).toList(),
    );
  }
}
