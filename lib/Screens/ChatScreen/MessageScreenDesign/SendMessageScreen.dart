 import 'package:flutter/material.dart';

import 'CustomPainter.dart';

class SendMessageScreen extends StatelessWidget {
 final String? message;
   SendMessageScreen({Key? key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Padding(
    padding: EdgeInsets.only(right: MediaQuery.of(context).padding.right+18.0,left:MediaQuery.of(context).padding.left+15.0, top:MediaQuery.of(context).padding.top+15.0, bottom:MediaQuery.of(context).padding.bottom+5.0),
    child: Row(
     mainAxisAlignment: MainAxisAlignment.start,
     children: <Widget>[
    SizedBox(height: MediaQuery.of(context).size.height*.2/3),
      messageTextGroup(message,context),
     ],
    ),
   );
  }
}
 Widget messageTextGroup(msg,context) => Flexible(
     child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Flexible(
        child: Container(
         padding: EdgeInsets.all(MediaQuery.of(context).size.height*.1/5.5),
         decoration:const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
           topLeft: Radius.circular(18),
           bottomLeft: Radius.circular(18),
           bottomRight: Radius.circular(18),
          ),
         ),
         child: Text(
          msg,
          style:const TextStyle(color: Colors.white, fontSize: 14),
         ),
        ),
       ),
       CustomPaint(painter: CustomShape(Colors.cyan)),
      ],
     ));