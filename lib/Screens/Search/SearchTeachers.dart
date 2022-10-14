import 'package:flutter/material.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';

import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../../Utility/Widget/NavigationBar1.dart';
import '../Teacher/DataTable/SlideableListView.dart';
class GetTeacherInDep extends StatefulWidget {
  const GetTeacherInDep({Key? key}) : super(key: key);

  @override
  State<GetTeacherInDep> createState() => _GetTeacherInDepState();
}

class _GetTeacherInDepState extends State<GetTeacherInDep> {
 var DepID;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget()),
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left:23,top: 15,bottom: 10,),
              child: text("Select Department here:-",FontWeight.normal,18.0,Colors.black38),
            ),
            Center(
              child: Container(
              //  margin: const EdgeInsets.only(left:15,right: 10,top: 15),
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.32/4,
                child: DepDD(callbackFunction: (newValue) { setState(() {
                  DepID=newValue;
                }); },),
              ),
            ),
            (DepID!=null)? Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left:23,top: 15,bottom: 10),
                    child: text("Here you got teacher list:-",FontWeight.normal,18.0,Colors.black38),
                  ),
                  Divider(
                    indent:20,
                    endIndent: 20,
                    thickness: 2,
                    height: 20,
                    color: Colors.orangeAccent,

                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                      child: AllTeachersData(departmentID: DepID,)),
                ],
              )
            ):Container(),

          ],
        ),
      ),

    );
  }
}
