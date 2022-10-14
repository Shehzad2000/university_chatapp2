import 'package:flutter/material.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/NavigationBar1.dart';
class PositionDetail extends StatefulWidget {
  const PositionDetail({Key? key}) : super(key: key);

  @override
  State<PositionDetail> createState() => _PositionDetailState();
}

class _PositionDetailState extends State<PositionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child: const AppBarWidget()),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10,left: 0),
            child: Text("Position Details:-",style: TextStyle(fontSize: 15,color: Colors.lightBlueAccent,
            ),),
          ),
          Divider(

            indent: 18,
            endIndent: 18,
            thickness: 1.3,
            height: 10,
            color: Colors.blue,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Position:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 50),

                child: text("Co-Ordinator",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Status:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("Active",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),child:navbar1()),
    );
  }
}

