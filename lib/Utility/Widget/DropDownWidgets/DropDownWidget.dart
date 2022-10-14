// ignore_for_file: file_names

import 'dart:core';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({Key? key, required this.callbackFunction}) : super(key: key);
  Function(String) callbackFunction;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  String dropdownvalue = '--- Status ---';

  String? value;

  // List of items in our dropdown menu
  final items = [
    '--- Status ---',
    'Active',
    'InActive',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callbackFunction(dropdownvalue);
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.32/4,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.1/8, ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              // Initial Value
/*
                    value: dropdownvalue,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
*/decoration:const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none

            ),

              value: dropdownvalue,
              isExpanded: true,
              iconSize: 36,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              // Array list of items
              items: items.map(BuildMenuItem).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (value) => setState(() => widget.callbackFunction(dropdownvalue=value!)),
            ),
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      ),
    );
