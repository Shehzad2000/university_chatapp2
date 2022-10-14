import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Contraints/Text.dart';
class ListTileWidget1 extends StatefulWidget {
  String? title,subtitle,image;

  ListTileWidget1({Key? key,this.title,this.subtitle,this.image}) : super(key: key);

  @override
  State<ListTileWidget1> createState() => _ListTile1WidgetState();
}

class _ListTile1WidgetState extends State<ListTileWidget1> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 16.0,
      leading:CircleAvatar(

        backgroundImage: AssetImage("assets/images/z.jpg"),
      ),
      title: text(widget.title.toString(),FontWeight.normal,17.0,Colors.white),
      subtitle:  text(widget.subtitle.toString(),FontWeight.normal,12.0,Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onTap: (){

      },

    );
  }
}