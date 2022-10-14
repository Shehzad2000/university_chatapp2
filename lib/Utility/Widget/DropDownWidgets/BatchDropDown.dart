import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/BatchBloc/batch_bloc.dart';
class BatchDD extends StatefulWidget {
  Function(String) callbackFunction;
  BatchDD({Key? key,required this.callbackFunction}) : super(key: key);

  @override
  State<BatchDD> createState() => _BatchDDState();

}

class _BatchDDState extends State<BatchDD> {
  BatchBloc? batchBloc;
  String? dropdownvalue;
  String? val;
  // List of items in our dropdown menu

  @override
  void initState() {
    batchBloc=BlocProvider.of<BatchBloc>(context);
    batchBloc!.add(GetAllBatchesEvent());
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

          //  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child:BlocBuilder<BatchBloc,BatchStates>(
            builder: (context,state){
              if(state is BatchLoadingState){
                return const CircularProgressIndicator();
              }else if(state is BatchShowDataState){

                return ListView.builder(itemCount: state.list!.length,itemBuilder: (context,index){
                  return     DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        // Initial Value
                        hint: Text("--- Select Batch ---",style: TextStyle(color:Colors.blue),),
                        value: dropdownvalue,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        decoration:const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,

                        ),
                        // Array list of items
                        items: state.list!.map((e) => BuildMenuItem(e.batchName!)).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (value) =>  setState(() {
                          dropdownvalue=state.list![index].batchName;
                          widget.callbackFunction(val = state.list![index].batchID!);}),
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
