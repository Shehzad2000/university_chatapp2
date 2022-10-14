/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/StudentBloc/student_bloc.dart';
class StudentDropDown extends StatefulWidget {
  Function(String) callbackFunction;
  StudentDropDown({Key? key,required this.callbackFunction}) : super(key: key);

  @override
  State<StudentDropDown> createState() => _StudentDropDownState();
}

class _StudentDropDownState extends State<StudentDropDown> {
  StudentBloc? studentBloc;
  String? dropdownvalue;
  String? StudentID;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left: 10,top: 5),
          width: MediaQuery.of(context).size.width * 0.9,

          //  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child:BlocBuilder<StudentBloc,StudentStates>(
            builder: (context,state){
              if(state is StudentSuccessState){
                return const CircularProgressIndicator();
              }else if(state is StudentRecordState){
                return ListView.builder(itemCount: state.list.length,itemBuilder: (context,index){
                  return     DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // Initial Value
                        hint: Text("--- Select  ---",style: TextStyle(color:Colors.blue),),
                        value: dropdownvalue,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),

                        // Array list of items
                        items: state.list.map((e) => BuildMenuItem(e.semesterName!)).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (value) =>  setState(() {
                          dropdownvalue=state.list[index].semesterName;
                          widget.callbackFunction(SemesterID = state.list[index].semesterID!);}),
                      ));

                });
              }
              return Container();
            },
          )

      ),
    );
  }
}

DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16,color: Colors.blue),
  ),

);



*/
