// ignore_for_file: file_names

import 'package:flutter/material.dart';
//For ForgetPassword
InkWell inkWellWidget()=> InkWell(
      child: const Text('Forget Password',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)),
      onTap: () => ('')
  );
Ink inKDecoration(String? text)=>Ink(
  decoration: BoxDecoration(
      gradient:const LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(30.0)
  ),
  child: Container(
    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
    alignment: Alignment.center,
    child: Text(
      "$text",
      textAlign: TextAlign.center,
      style:const TextStyle(
          color: Colors.white,fontSize: 20
      ),
    ),
  ),
);