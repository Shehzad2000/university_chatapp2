import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var textStyle=const TextStyle(
      color: Colors.redAccent,
      fontSize: 18,
      fontWeight: FontWeight.bold

);
TextStyle txtStyle(FontStyle fontStyle,int color){
  return TextStyle(
    color: color==1?Colors.blue:Colors.white,
    fontStyle: fontStyle,

  );
}