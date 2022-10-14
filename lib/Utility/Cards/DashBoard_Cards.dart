import 'package:flutter/material.dart';

import '../../Screens/utils/constants.dart';
import '../Contraints/Gradient_contraints.dart';
import '../Widget/IconButtons.dart';
import '../Contraints/Text.dart';
class cards extends StatefulWidget {
  String? title,subTitle;
  Function? function;
   cards({Key? key,this.title,this.subTitle,this.function}) : super(key: key);

  @override
  State<cards> createState() => _cardsState();
}

class _cardsState extends State<cards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // margin:const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.1/10)
      ),
      color: Colors.transparent,
      //  shadowColor: Colors.orange,
      child: Column(
        children: [
          ListTile(
            title: text(widget.title.toString(), FontWeight.normal,23.0,Colors.white, ),
            subtitle: text(widget.subTitle.toString(), FontWeight.normal, 14.0,Colors.white, ),
            trailing: iconButton(
              Icons.arrow_forward, Constants.background, 25.0,),
            onTap: () {
              widget.function!();
            },
          ),

        ],
      ),
    );
  }
}


Card card(String title,String subTitle,Function function,BuildContext context) {
  return Card(
    margin:const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1/6)
    ),
    color: Colors.transparent,
   // shadowColor: Colors.orange,
    child: Column(
      children: [
        ListTile(
          title: text(title, FontWeight.normal,21.0,Colors.white, ),
          subtitle: text(subTitle, FontWeight.normal, 14.0,Colors.white, ),
          trailing: iconButton(
            Icons.arrow_forward, Constants.background, 25.0,),
          onTap: () {
            function();
          },
        ),

      ],
    ),
  );
}




