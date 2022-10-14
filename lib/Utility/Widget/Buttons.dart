// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String? title;
  VoidCallback? onPressed;

  MyButton({Key? key, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
      onPressed: () => onPressed,
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff374ABE), Color(0xff64B6FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
