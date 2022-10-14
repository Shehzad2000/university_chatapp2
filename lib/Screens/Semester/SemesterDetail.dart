import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_Bloc.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_State.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/NavigationBar1.dart';
class SemesterDetail extends StatefulWidget {
  const SemesterDetail({Key? key}) : super(key: key);

  @override
  State<SemesterDetail> createState() => _SemesterDetailState();
}

class _SemesterDetailState extends State<SemesterDetail> {
  SemesterBloc? semesterBloc;
  @override
  void initState() {
    semesterBloc=BlocProvider.of<SemesterBloc>(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget()),
      body: BlocBuilder<SemesterBloc, SemesterStates>(
        builder: (context, state) {
          if(state is SemesterLoadingState){
            return Center(child: CircularProgressIndicator());
          }
          else if(state is SemesterShowDataState)
          { return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (BuildContext context,int index){

                return Column(
                  children: [
                    /*Container(
           margin: EdgeInsets.only(top:30,left: 10),
           child: Text("Welcome to the",style: TextStyle(fontSize: 33,color: Colors.lightBlueAccent,shadows: [
             Shadow(
                 color: Colors.white30,
                 offset: Offset(4, 4),
                 blurRadius: 5),
           ]),),
         ),*/
                    Container(
                      margin: EdgeInsets.only(top: 10,left: 0),
                      child: Text("ComputerScience Department Details:-",style: TextStyle(fontSize: 15,color: Colors.lightBlueAccent,
                      ),),
                    ),
                    const Divider(
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
                          child: text("Name:",FontWeight.bold,20.0,Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15,left: 50),

                          child: text(state.list[index].semesterName!,FontWeight.normal,20.0,Colors.lightBlueAccent),
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

                          child: text(state.list[index].semesterStatus==1?"Active":"InActive",FontWeight.normal,20.0,Colors.lightBlueAccent),
                        ),
                      ],
                    )
                  ],
                );
              });
          }
          return Container();
        },
      ),
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),child:navbar1()),
    );
  }
}
