import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_Event.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_State.dart';

import '../../../Bloc/SemesterBloc/Semester_Bloc.dart';
class SemesterDropDown extends StatefulWidget {
  Function(String) callbackFunction;
   SemesterDropDown({Key? key,required this.callbackFunction}) : super(key: key);

  @override
  State<SemesterDropDown> createState() => _SemesterDropDownState();
}

class _SemesterDropDownState extends State<SemesterDropDown> {
  SemesterBloc? semesterBloc;
  String? dropdownvalue;
  String? SemesterID;
  @override
  void initState() {
    semesterBloc=BlocProvider.of<SemesterBloc>(context);
    semesterBloc!.add(GetSemestersEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.32 / 4,
          padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left+10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child:BlocBuilder<SemesterBloc,SemesterStates>(
            builder: (context,state){
              if(state is SemesterLoadingState){
                return const CircularProgressIndicator();
              }else if(state is SemesterShowDataState){
                return ListView.builder(itemCount: state.list.length,itemBuilder: (context,index){
                  return     DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        decoration:const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none
                        ),
                        // Initial Value
                        hint:const Text("--- Select Semester ---",style: TextStyle(color:Colors.blue),),
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


