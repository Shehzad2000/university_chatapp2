import 'package:flutter/material.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/BatchDropDown.dart';

import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../Student/DataTable/SlideableListView.dart';
class SearchStudentInBatch extends StatefulWidget {
  const SearchStudentInBatch({Key? key}) : super(key: key);

  @override
  State<SearchStudentInBatch> createState() => _SearchStudentInBatchState();
}

class _SearchStudentInBatchState extends State<SearchStudentInBatch> {
  String? batchID;
  String? Department;
  String? semID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget()),
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/6,),
                    child: text("Select Department here:-",FontWeight.normal,18.0,Colors.black38),
                  ),
                  Center(
                    child: Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/10),
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.32/4,
                        child:DepDD(callbackFunction:(newValue){
                          setState(() {
                          Department=newValue;
                          });
                        })
                    ),
                  ),
                  (Department!=null)?Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/8,bottom: MediaQuery.of(context).size.height*0.1/10),
                          child: text("Select Semester here:-",FontWeight.normal,18.0,Colors.black38),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.32/4,
                          child: BatchDD(callbackFunction: (newValue) { setState(() {
                            semID=newValue;
                          }); },),
                        ),
                      ]):Container(),
                  (semID!=null)?Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/8,bottom: MediaQuery.of(context).size.height*0.1/10),
                        child: text("Select Batch here:-",FontWeight.normal,18.0,Colors.black38),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.32/4,
                        child: BatchDD(callbackFunction: (newValue) { setState(() {
                          batchID=newValue;
                        }); },),
                      ),
                    ],
                  ):Container(),
                  (batchID!=null&&Department!=null&&semID!=null)? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(children: [
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/18),
                          child: Center(child: text("Here you got student list:-",FontWeight.normal,18.0,Colors.black38)),
                        ),
                        Divider(
                          indent:20,
                          endIndent: 20,
                          thickness: 2,
                          height: MediaQuery.of(context).size.height*0.1/6,
                          color: Colors.orangeAccent,

                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: GetAllStudentData(batchID: batchID,Department:Department,semID:semID)),
                      ],)
                  ):Container(),
                ]),





              ],
            ),


        ),


    );
  }
}
