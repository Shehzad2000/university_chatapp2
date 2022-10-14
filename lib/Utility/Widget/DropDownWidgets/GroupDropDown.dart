import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/GroupBloc/Group_Bloc.dart';
import '../../../Bloc/GroupBloc/Group_State.dart';
class GetAllGroups extends StatefulWidget {
  Function(String) callbackFunction;
   GetAllGroups({Key? key,required this.callbackFunction}) : super(key: key);

  @override
  State<GetAllGroups> createState() => _GetAllGroupsState();
}

class _GetAllGroupsState extends State<GetAllGroups> {
  GroupBloc? groupBloc;
  String? dropdownvalue;
  String? GroupID;
  @override
  void initState() {
    groupBloc=BlocProvider.of<GroupBloc>(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width * 0.9,

          //  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child:BlocBuilder<GroupBloc,GroupStates>(
            builder: (context,state){
              if(state is GroupLoadingState){
                return const CircularProgressIndicator();
              }else if(state is ShowGroupData){
                return ListView.builder(itemCount: state.list.length,itemBuilder: (context,index){
                  return     DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // Initial Value
                        hint: Text("--- Select Group ---",style: TextStyle(color:Colors.blue),),
                        value: dropdownvalue,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),

                        // Array list of items
                        items: state.list.map((e) => BuildMenuItem(e.groupName!)).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (value) =>  setState(() {
                          widget.callbackFunction(GroupID = state.list[index].groupID!);
                          dropdownvalue = state.list[index].groupName!;}),
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