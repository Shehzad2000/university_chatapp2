
import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  CustomPageRoute({required this.child}) : super(
      transitionDuration: Duration(microseconds:1),
      pageBuilder: (context,animation,secondaryAnimation)=>child);

 @override
Widget BuildTransition(BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation,Widget child)=>
     ScaleTransition(scale: animation,child: child,);
}