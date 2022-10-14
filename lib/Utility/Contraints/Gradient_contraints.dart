

import 'package:flutter/material.dart';

LinearGradient gradients(dynamic begins,dynamic ends,dynamic color1,dynamic color2,dynamic color3,) {
return LinearGradient(

    colors: [color1,color2,color3],
  begin: begins,
  end: ends,
);
}
LinearGradient gradient(dynamic begins,dynamic ends,dynamic color1,dynamic color2) {
  return LinearGradient(

    colors: [color2,color1],
    begin: begins,
    end: ends,
  );
}
