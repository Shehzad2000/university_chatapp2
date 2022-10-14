// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Screens/Dashboard/Dashboard.dart';
import '../../Screens/Department/Department.dart';
import '../../Screens/Position/Position.dart';
import '../../Screens/Profile/AdminProfile/AdminProfile.dart';
import '../../Screens/Search/SearchStudents.dart';
import '../../Screens/Search/SearchTeachers.dart';
import '../../Screens/Semester/Semester.dart';
import 'NavigationBar1.dart';

class MyNav extends StatefulWidget {
  MyNav({Key? key}) : super(key: key);

  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  var item = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.search, size: 30),
    Icon(Icons.favorite, size: 30),
    Icon(Icons.settings, size: 30),
    Icon(Icons.person, size: 30)
  ];

  List<Widget> list = [
    Dashboard(),
    Semester(),
    Department(),
    EmployeePosition(),
  ];

  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.lightBlueAccent,
        color: Colors.blue,
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        index: index,
        items: item,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}

class navbar2  extends StatefulWidget {

  navbar2({Key? key}) : super(key: key);

  @override
  State<navbar2> createState() => _navbar2State();
}

class _navbar2State extends State<navbar2> {
  var item = const <Widget>[
    Icon(Icons.home, size: 30,color: Colors.white,),
    Icon(Icons.search, size: 30,color: Colors.white,),
    FaIcon(FontAwesomeIcons.userGraduate,size: 25,color: Colors.white,),
    FaIcon(FontAwesomeIcons.chalkboardTeacher,size: 25,color: Colors.white,),
    // Icon(Icons.settings, size: 30,color: Colors.white,),
    Icon(Icons.person, size: 30,color: Colors.white,)
  ];
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.lightBlueAccent,
        color: Colors.blue,
        animationCurve: Curves.bounceInOut,
        animationDuration:const Duration(milliseconds: 400),
        height: MediaQuery.of(context).size.height*0.1/1.45,
        index: index,
        items: item,
        onTap: (index) => setState(() {
          this.index = index;
        if(this.index>0) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => navbar1(ind: index,)));
        }
        }));
  }
}
