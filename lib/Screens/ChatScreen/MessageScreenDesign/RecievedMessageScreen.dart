import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'CustomPainter.dart';
class RecievedMessageScreen extends StatelessWidget {
  String? message;
   RecievedMessageScreen({Key? key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).padding.right+18.0,left:MediaQuery.of(context).padding.left+15.0, top:MediaQuery.of(context).padding.top+15.0, bottom:MediaQuery.of(context).padding.bottom+5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*.1/2.3),
          messageTextGroup(message),
        ],
      ),
    );
  }
}


Widget messageTextGroup(msg) => Flexible(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: CustomShape(Colors.grey),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              msg,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    ));