import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:university_chatapp2/Screens/Batch/BatchScreen.dart';
import 'package:university_chatapp2/Screens/Department/Department.dart';
import 'package:university_chatapp2/Screens/Position/Position.dart';
import 'package:university_chatapp2/Screens/Semester/Semester.dart';
import 'package:university_chatapp2/Utility/Widget/CustomPageRoute.dart';

import '../../Screens/Batch/BatchData.dart';
import '../../Screens/Department/DepartmentList.dart';
import '../../Screens/Groups/GroupList.dart';

import '../../Screens/Position/DataTable1/SlideableListView.dart';
import '../../Screens/Semester/DataTable/SlideableListView.dart';
import '../Contraints/Gradient_contraints.dart';
import '../Contraints/Text.dart';
class Dashboard_Cards2 extends StatefulWidget {
   Dashboard_Cards2({Key? key}) : super(key: key);

  @override
  State<Dashboard_Cards2> createState() => _Dashboard_Cards2State();
}

class _Dashboard_Cards2State extends State<Dashboard_Cards2> {
  var icons=const <Widget>[
    FaIcon(FontAwesomeIcons.school,size: 65,color: Colors.white,),
    FaIcon(FontAwesomeIcons.userGroup,size: 65,color: Colors.white,),
    FaIcon(FontAwesomeIcons.solidObjectGroup,size: 65,color: Colors.white,),
    FaIcon(FontAwesomeIcons.calendarXmark,size: 65,color: Colors.white,),
    FaIcon(FontAwesomeIcons.userSecret,size: 65,color: Colors.white,),
  ];
  var route=<Widget>[
    DepartmentData(),
    BatchData(),
    GroupsDataTable(),
    SemesterData(),
    PositionData()
  ];
  var texts=<Widget>[
    text("Department",FontWeight.normal,17.0,Colors.white),
    text("Batch",FontWeight.normal,17.0,Colors.white),
    text("Group",FontWeight.normal,17.0,Colors.white),
    text("Semester",FontWeight.normal,17.0,Colors.white),
    text("Position",FontWeight.normal,17.0,Colors.white),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
          itemCount: icons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context,int index){
            return   GestureDetector(
              child:Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.height*0.45/2,

                margin: const EdgeInsets.only(left: 15,right:5,bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width*0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      gradient: gradients(Alignment.centerRight, Alignment.center, Colors.deepPurple,Colors.deepPurpleAccent,Colors.indigo)
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    color: Colors.white70,
                    //  color: Colors.blueGrey.shade800,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          gradient: gradients(Alignment.centerRight, Alignment.center, Colors.deepPurple,Colors.deepPurpleAccent,Colors.indigo)
                      ),

                      child: Stack(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height*0.3,
                              width: MediaQuery.of(context).size.width*0.6,
                              //  color: Colors.blue,
                              child: Center(child:icons[index])
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 140,left: 53),

                            height: MediaQuery.of(context).size.height*0.7/10,
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Center(child:texts[index]),
                          )
                        ],

                      ),
                    ),
                    // elevation: 8,
                    // shadowColor: Colors.blue,
                    // margin: EdgeInsets.all(20),
                  ),
                ),
              ),onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>route[index],

                ),
              );
             /* Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.topToBottom,
                  duration: Duration(seconds: 2),
                  alignment: Alignment.center,
                  reverseDuration: Duration(seconds: 2),
                  opaque: true,
                  isIos: true,
                  child: route[index],
                ),
              );*/

            /*  Navigator.push(context, CustomPageRoute(child: ));*/
            },
            );
          }),







    );
  }
}
