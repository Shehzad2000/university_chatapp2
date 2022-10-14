import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Repo/TeacherRepo.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/NavigationBar1.dart';

import '../../Bloc/TeacherBloc/Teacher_Bloc.dart';
class TeacherDetail extends StatefulWidget {
  const TeacherDetail({Key? key}) : super(key: key);

  @override
  State<TeacherDetail> createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail> {
  void showData() async{
    TeacherFireBase obj=TeacherFireBase();
    var data = await  obj.GetTeachers();
    print(data);
  }
  @override
  void initState() {

    showData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget()),
      body: BlocBuilder<TeacherBloc, TeacherStates>(
  builder: (context, state) {
    return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10,left: 0),
            child: Text("Teacher Details:-",style: TextStyle(fontSize: 15,color: Colors.lightBlueAccent,
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
                child: text("AdminName:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 50),

                child: text("Salman",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Name:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("Papa Ki Pari",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Department:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("23/2/1992",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Email:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),
                child: text("m.shehzad@gmail.com",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Contact:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("23/2/1992",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Gender:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("23/2/1992",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("RegDate:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("23/2/1992",FontWeight.normal,20.0,Colors.lightBlueAccent),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15,left: 20),
                child: text("Image:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 45),

                child: text("23/2/1992",FontWeight.normal,20.0,Colors.lightBlueAccent),
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
      );
  },
),
    );
  }
}
