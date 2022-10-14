import 'package:flutter/cupertino.dart';

Text text(String name,FontWeight fontWeight,dynamic size,Color color) =>Text(
      name,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: size,
          color: color),
);