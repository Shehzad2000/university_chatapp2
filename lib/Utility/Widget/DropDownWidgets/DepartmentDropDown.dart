import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_Event.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';

import '../../../Bloc/DepartmentBloc/Department_Bloc.dart';

class DepDD extends StatefulWidget {
  Function(String) callbackFunction;
  DepDD({Key? key, required this.callbackFunction}) : super(key: key);

  @override
  State<DepDD> createState() => _DepDDState();
}

class _DepDDState extends State<DepDD> {
  DepartmentBloc? departmentBloc;
  String? dropdownvalue;
  String? val;
  // List of items in our dropdown menu

  @override
  void initState() {
    departmentBloc = BlocProvider.of<DepartmentBloc>(context);
    departmentBloc!.add(GetAllDepartmentsEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left+10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.32 / 4,

          //    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child: BlocBuilder<DepartmentBloc, DepartmentStates>(
            builder: (context, state) {
              if (state is DepartmentLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is DepartmentShowDataState) {
                return ListView.builder(
                    itemCount: state.list!.length,
                    itemBuilder: (context, index) {
                      return DropdownButtonFormField<String>(
                        validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Select any field";
                      }
                        },
                        // Initial Value
                          decoration:const InputDecoration(
                              enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none

                          ),
                        hint:const Text(
                      "--- Select Department ---",
                      style: TextStyle(color: Colors.blue),
                        ),
                        value: dropdownvalue,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                        ),

                        // Array list of items
                        items: state.list!
                        .map((e) => BuildMenuItem(e.departmentName!))
                        .toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (value) => setState(() {
                      dropdownvalue = state.list![index].departmentName;
                      widget.callbackFunction(
                          val = state.list![index].departmentID!);
                        }),
                      );
                    });
              }
              return Container();
            },
          )),
    );
  }
}

DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style:const TextStyle(
            fontWeight: FontWeight.normal, fontSize: 16, color: Colors.blue),
      ),
    );
