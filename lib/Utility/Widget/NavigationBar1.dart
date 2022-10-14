
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university_chatapp2/Screens/Department/Department.dart';

// ignore_for_file: file_names
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:university_chatapp2/Screens/Dashboard/Dashboard.dart';

import 'package:university_chatapp2/Screens/Position/Position.dart';
import 'package:university_chatapp2/Screens/RegisterCourses/RegisterCourses.dart';

import '../../Screens/Profile/AdminProfile/AdminProfile.dart';
import '../../Screens/Search/SearchStudents.dart';
import '../../Screens/Search/SearchTeachers.dart';
import '../../Screens/Semester/Semester.dart';

class navbar1  extends StatefulWidget {
 var ind;
  navbar1({Key? key,this.ind}) : super(key: key);

  @override
  State<navbar1> createState() => _navbar1State();
}

class _navbar1State extends State<navbar1> {
  var item = const <Widget>[
    Icon(Icons.home, size: 30,color: Colors.white,),
    Icon(Icons.search, size: 30,color: Colors.white,),
    FaIcon(FontAwesomeIcons.userGraduate,size: 25,color: Colors.white,),
    FaIcon(FontAwesomeIcons.chalkboardTeacher,size: 25,color: Colors.white,),
   // Icon(Icons.settings, size: 30,color: Colors.white,),
    Icon(Icons.person, size: 30,color: Colors.white,)
  ];

  List<Widget> list = [
    const Dashboard(),
    const RegisterCourses(),
    const SearchStudentInBatch(),
    const GetTeacherInDep(),
    const AdminProfile()
  ];

  var index = 0;
  @override
  void initState() {
    (widget.ind==null||widget.ind<0)?(index=index):(index=widget.ind);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.lightBlueAccent,
        color: Colors.blue,
        animationCurve: Curves.decelerate,
        animationDuration:const Duration(milliseconds: 400),
        height: MediaQuery.of(context).size.height*0.1/1.45,
        index: index,
        items: item,
        onTap: (index) {
          setState(() {
            this.index = index;
          });

        },
      ),
    );
  }
}
