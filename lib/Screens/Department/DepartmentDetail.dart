import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';

import '../../Bloc/DepartmentBloc/Department_Bloc.dart';
import '../../Bloc/DepartmentBloc/Department_Event.dart';
import '../../Utility/Widget/MyNav.dart';
import '../../Utility/Widget/NavigationBar1.dart';
class DepartmentDetail extends StatefulWidget {
  const DepartmentDetail({Key? key}) : super(key: key);

  @override
  State<DepartmentDetail> createState() => _DepartmentDetailState();
}

class _DepartmentDetailState extends State<DepartmentDetail> {
 DepartmentBloc? departmentBloc;
 @override
  void initState() {
   departmentBloc = BlocProvider.of<DepartmentBloc>(context);
   departmentBloc!.add(GetAllDepartmentsEvent());// TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget()),
      body: BlocBuilder<DepartmentBloc, DepartmentStates>(
  builder: (context, state) {
    if(state is DepartmentLoadingState){
      return Center(child: CircularProgressIndicator());
    }
    else if(state is DepartmentShowDataState)
      { return ListView.builder(
        itemCount: state.list!.length,
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
                child: text("Name:",FontWeight.bold,20.0,Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,left: 50),

                child: text(state.list![index].departmentName!,FontWeight.normal,20.0,Colors.lightBlueAccent),
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

                child: text(state.list![index].departmentStatus==1?"Active":"InActive",FontWeight.normal,20.0,Colors.lightBlueAccent),
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
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),child:navbar2()),
    );
  }
}
