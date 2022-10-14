import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Bloc.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Event.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_State.dart';
import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';
import 'package:university_chatapp2/Screens/Position/Position.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';

import '../../../Utility/Widget/MyNav.dart';

class PositionData extends StatefulWidget {
  PositionData({Key? key}) : super(key: key);

  @override
  State<PositionData> createState() => _PositionDataState();
}

class _PositionDataState extends State<PositionData> {
  PositionBloc? positionBloc;
  @override
  void initState() {
    positionBloc = BlocProvider.of<PositionBloc>(context);
    positionBloc!.add(GetAllPositions());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EmployeePosition()));
        },
      ),
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.14), child:const AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/9),
              child: Center(child: text("Here you got Position list:-",FontWeight.normal,18.0,Colors.black38)),
            ),
            Divider(
              indent:20,
              endIndent: 20,
              thickness: 2,
              height: MediaQuery.of(context).size.height*0.1/10,
              color: Colors.orangeAccent,
            ),
               Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<PositionBloc, PositionStates>(
                  builder: (context, state) {
                    if (state is PositionLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PositionShowDataState) {
                      return ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/7,right: MediaQuery.of(context).size.height*0.1/7),
                                shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                elevation: 10,
                                child: Slidable(
                                  startActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    //   dismissible: DismissiblePane(onDismissed: (){},),
                                    children: [
                                      SlidableAction(
                                        onPressed: (BuildContext context) async {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => EmployeePosition(
                                                    requestModel: PositionRequestModel(
                                                        positionID:
                                                            state.list[index].positionID!,
                                                        positionStatus: state
                                                            .list[index].positionStatus,
                                                        positionName: state
                                                            .list[index].positionName),
                                                  )));
                                        },
                                        backgroundColor:const Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit_rounded,
                                        label: 'Edit',
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion:const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (BuildContext context) async {
                                          DeletePressed(state.list[index].positionID);
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top+2, bottom: MediaQuery.of(context).padding.bottom+2),
                                    child: ListTile(
                                      leading:
                                         const CircleAvatar(child: Icon(CupertinoIcons.heart)),
                                      title: text(state.list[index].positionName.toString(), FontWeight.normal,
                                          20.0, Colors.blue),
                                      subtitle: text("Description", FontWeight.normal,
                                          12.0, Colors.blue),
                                      trailing: IconButtonWidget(
                                        iconData: CupertinoIcons.text_justify,
                                        color: Colors.blue,
                                        size: 25.0,
                                        onPressed: null,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0)),
                                      onTap: () {
                                        OpenDialog(state.list[index]);
                                      },
                                    ),
                                  ),
                                ));
                          });
                    } else if (state is DepartmentErrorState) {
                      return const Center(child: Text("Oops,Something went wrong"));
                    }

                    return Container();
                  },
                ),
              ),

          ],
        ),
      ),
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()),
    );
  }

  void DeletePressed(String? PID) {
    positionBloc!.add(DeletePositionEvent(PID));
  }

  void OnPressed(int index) {
    setState(() {});
  }

  Future OpenDialog(PositionRequestModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1/5)
      ),

      scrollable: true,
      content:SizedBox(
        height: MediaQuery.of(context).size.height*(0.2/1.6),
        width: MediaQuery.of(context).size.width*.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text("Position Detail",style: TextStyle(color: Colors.black),),
              ),
              const Divider(
                color: Colors.black26,
              ),
              Row(
                children: [
                  /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                  Container(
                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                      child:const Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.positionName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                  ),

                ],
              ),
              Row(
                children: [
                  /* Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                  Container(
                      margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                      child:const Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                      child: Text('${model.positionStatus}'==1?"Active":"InActive",style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),))
                ],
              )



            ],
          ),
        ),
      )


  ));
}
