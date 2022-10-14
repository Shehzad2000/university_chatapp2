import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

MaterialButton socialButtons(IconData icon,BuildContext context){
  return MaterialButton(
    onPressed: (){},
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: MediaQuery.of(context).size.height*0.1/2.5,
      child: CircleAvatar(
        radius:  MediaQuery.of(context).size.height*0.1/2.8,
        child: Icon(icon,size: 30,),
      ),
    ),
  );
}