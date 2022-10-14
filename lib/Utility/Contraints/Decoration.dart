// ignore_for_file: file_names
//Container Decoration
import 'package:flutter/material.dart';

import '../Widget/IconButtons.dart';
InputDecoration buildInputDecoration(String labelText,int colors,dynamic filledColor)  =>  InputDecoration(
      labelText: labelText,
      labelStyle:TextStyle(
        color: colors==1?Colors.blue:Colors.white,
      fontStyle: FontStyle.italic,
      ),
  contentPadding: EdgeInsets.symmetric(vertical: 22,horizontal: 10),
  fillColor: const Color.fromRGBO(140, 126, 126, 0.4),
  filled: filledColor,
  enabledBorder:OutlineInputBorder(
  borderRadius:const BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color:colors==1?Colors.blue:Colors.white,),
  ),

  focusedBorder: OutlineInputBorder(
  borderRadius:const BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color:colors==1?Colors.blue:Colors.white,),
  ),
    errorBorder:const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color:Colors.redAccent,),
    ),
  focusedErrorBorder:const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color:Colors.redAccent,),
  )
);

InputDecoration buildInputDecoration1(String labelText,int colors,dynamic filledColor,bool isPasswordTextField)  =>  InputDecoration(
    suffixIcon: isPasswordTextField?iconButton(Icons.remove_red_eye, Colors.grey, 15):null,
    contentPadding: EdgeInsets.symmetric(vertical: 22,horizontal: 10),
    labelText: labelText,
  labelStyle:TextStyle(
    color: colors==1?Colors.blue:Colors.white,
    fontStyle: FontStyle.italic,
  ),
  fillColor: const Color.fromRGBO(140, 126, 126, 0.4),
  filled: filledColor,
  enabledBorder:OutlineInputBorder(
    borderRadius:const BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color:colors==1?Colors.blue:Colors.white,),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius:const BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color:colors==1?Colors.blue:Colors.white,),
  ),
  errorBorder: OutlineInputBorder(
borderRadius:const BorderRadius.all(Radius.circular(12.0)),
borderSide: BorderSide(color:Colors.redAccent,),
),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius:const BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color:Colors.redAccent,),
    ),
);

Decoration decorationImage(){
  return  const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/B1.jpg'),fit: BoxFit.cover));
}