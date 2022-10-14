// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Contraints/Text.dart';
import 'IconButtons.dart';
class ListTileWidget extends StatefulWidget {
  String? title,subtitle;

   ListTileWidget({Key? key,this.title,this.subtitle}) : super(key: key);

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child:Icon(CupertinoIcons.heart)
      ),
      title: text(widget.title.toString(),FontWeight.normal,17.0,Colors.blue),
      subtitle:  text(widget.subtitle.toString(),FontWeight.normal,12.0,Colors.blue),
      trailing: iconButton(CupertinoIcons.arrow_right_circle_fill,Colors.blue,25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onTap: (){

      },
    );
  }
}
/*
Widget build(BuildContext context) {
  return Card(
    margin: EdgeInsets.only(top:10,left: 15,right: 15,bottom: 10),
    shadowColor: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    color: Colors.white,
    elevation: 10,
    child: ListTile(
      leading: CircleAvatar(
          child:Icon(CupertinoIcons.heart)
      ),
      title: text(widget.title.toString(),FontWeight.normal,20.0,Colors.blue),
      // subtitle:  text(null,FontWeight.normal,12.0,Colors.blue),
      trailing: iconButton(CupertinoIcons.arrow_right_circle_fill,Colors.blue,25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onTap: (){

      },
    ),
  );
}
*/
class ChatScreenListTile extends StatefulWidget {
  String? title,subtitle;
  void Function()? onTap;
  ChatScreenListTile({Key? key,this.title,this.subtitle,this.onTap}) : super(key: key);

  @override
  State<ChatScreenListTile> createState() => _ChatScreenListTileState();
}

class _ChatScreenListTileState extends State<ChatScreenListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(

      horizontalTitleGap: 16.0,
      leading: CircleAvatar(
radius: 24,
        backgroundImage: AssetImage("assets/images/z.jpg"),

      ),

      title: text(widget.title.toString(),FontWeight.normal,17.0,Colors.blue),
      subtitle:  Row(
        children: [
          Icon(Icons.done,size: 15,),
          text(widget.subtitle.toString(),FontWeight.normal,12.0,Colors.blue),
        ],
      ),
      trailing: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),

            child: Text("23/02/2022",style: TextStyle(fontSize: 10),),
          ),
          Container(
            height: 3,
            child: IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 12,)),
          )
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onTap: widget.onTap,
    );
  }
}