import 'package:flutter/material.dart';

import '../../Screens/utils/constants.dart';
const TextStyle display1=TextStyle(
 // color: Colors.redAccent,
  color: Colors.white,
  fontSize:24,
  fontWeight: FontWeight.bold,
);
var decAppContainer= Container(
  decoration:const BoxDecoration(
    gradient: LinearGradient(
      //  colors: [Color(0xFF696D77),Color(0xFF292C36)],
        colors: [Colors.blue,Colors.indigo],
        begin:Alignment.bottomRight,
      end: Alignment.topLeft,
      tileMode: TileMode.clamp
    )
  ),
);
var decContainer=
  const BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xFF696D77),Color(0xFF292C36)],

          begin:Alignment.bottomRight,
          end: Alignment.topLeft,
          tileMode: TileMode.clamp
      )
  );

var decorationContainer=
      BoxDecoration(
        gradient:const LinearGradient(
         // Constants.secondaryThemeColor,
         // Constants.themeColor.withOpacity(0.7),
         // colors: [Color(0xFF292C36),Color(0xFF292C36),Color(0xFF696D77),],
            colors: [Colors.deepPurple,Colors.deepPurpleAccent,Colors.indigo],
         begin: Alignment.bottomLeft, end: Alignment.topRight),
        boxShadow: [Constants.boxShadow],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)));