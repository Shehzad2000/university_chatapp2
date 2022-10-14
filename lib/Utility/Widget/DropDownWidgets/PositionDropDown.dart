import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Bloc.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Event.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_State.dart';
class PositionDropDown extends StatefulWidget {
  Function(String) callbackFunction;
  PositionDropDown({Key? key,required this.callbackFunction}) : super(key: key);

  @override
  State<PositionDropDown> createState() => _PositionDropDownState();
}

class _PositionDropDownState extends State<PositionDropDown> {
  PositionBloc? positionBloc;
  String? dropdownvalue;
  String? PositionID;
  @override
  void initState() {
    // TODO: implement initState
    positionBloc=BlocProvider.of<PositionBloc>(context);
    positionBloc!.add(GetAllPositions());
    super.initState();
  }
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
          child:BlocBuilder<PositionBloc,PositionStates>(
            builder: (context,state){
              if(state is PositionLoadingState){
                return const CircularProgressIndicator();
              }else if(state is PositionShowDataState){
                return ListView.builder(itemCount: state.list.length,itemBuilder: (context,index){
                  return     DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // Initial Value
                        hint: Text("--- Select Position ---",style: TextStyle(color:Colors.blue),),
                        value: dropdownvalue,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),

                        // Array list of items
                        items: state.list.map((e) => BuildMenuItem(e.positionName!)).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (value) =>  setState(() {
                          dropdownvalue = state.list[index].positionName!;
                          widget.callbackFunction(PositionID=state.list[index].positionID!);
                        }),
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
