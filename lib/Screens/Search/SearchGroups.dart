import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/CreateGroupModel.dart';
import 'package:university_chatapp2/Screens/ChatScreen/MessageScreen.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/BatchDropDown.dart';

import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../../Utility/Widget/DropDownWidgets/SemesterDropDown.dart';
class SearchGroupsByAdmin extends StatefulWidget {
  const SearchGroupsByAdmin({Key? key}) : super(key: key);

  @override
  State<SearchGroupsByAdmin> createState() => _SearchGroupsByAdminState();
}

class _SearchGroupsByAdminState extends State<SearchGroupsByAdmin> {
  var searchdepID;

  var searchSemesterID;

  var batchID;

  var createGroupID;

  CreateGroupBloc? createGroupBloc;



  @override
  void initState() {
    createGroupBloc=BlocProvider.of<CreateGroupBloc>(context);
    createGroupBloc!.add(GetGroupsByDepSemAndBatchID(departmentID:searchdepID,semesterID:searchdepID,batchID:batchID));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height*0.13),
        child:const AppBarWidget(),
      ),
        body: SingleChildScrollView(
          child: Form(
            child: Center(
              child: Column(
                children: [
                  Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.1/5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height *
                          0.32 /
                          4,
                      child: DepDD(
                          callbackFunction: DepartmentCallBackFunction)),
                  (searchdepID!=null)?Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.1/5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height *
                          0.32 /
                          4,
                      child: SemesterDropDown(
                          callbackFunction: SearchSemesterCallBackFunction)):Container(),

                  (searchSemesterID!=null)?Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.1/5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height *
                          0.32 /
                          4,
                      child: BatchDD(
                          callbackFunction: BatchCallBackFunction)):Container(),

                  (searchdepID!=null&&searchSemesterID!=null&&batchID!=null)? Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                        child: text("Here you got Group list:-",FontWeight.normal,18.0,Colors.black38),
                      ),
                      Divider(
                        indent:20,
                        endIndent: 20,
                        thickness: 2,
                        height: MediaQuery.of(context).size.height*0.1/10,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(
                        // margin:  EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width ,
                        height: MediaQuery.of(context).size.height,
                        child: BlocBuilder<CreateGroupBloc, CreateGroupStates>(
                          builder: (context, state) {
                            if (batchID != null) {
                              if (state is CreateGroupLoadingState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is CreateGroupShowDataState) {
                                return ListView.builder(
                                    itemCount: state.list!.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return Card(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height*0.1/5, left: MediaQuery.of(context).size.height*0.1/6.5, right: MediaQuery.of(context).size.height*0.1/6.5),
                                          shadowColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15.0),
                                          ),
                                          color: Colors.white,
                                          elevation: 10,
                                          child: Slidable(
                                            startActionPane: ActionPane(
                                              motion:const DrawerMotion(),
                                              //   dismissible: DismissiblePane(onDismissed: (){},),
                                              children: [

                                                SlidableAction(
                                                  onPressed: (BuildContext context) async {
                                                       },
                                                  backgroundColor:Colors.orangeAccent,
                                                  foregroundColor: Colors.white,
                                                  icon: FontAwesomeIcons.userGraduate,
                                                  label: 'Go To Student List',
                                                ),

                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              motion: const DrawerMotion(),
                                              children: [
                                                SlidableAction(onPressed: (BuildContext context) async{
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageScreen(
                                                      createGroupModel: state.list![index],
                                                    )));
                                                },
                                                  backgroundColor: Colors.deepOrangeAccent,
                                                  foregroundColor: Colors.white,
                                                  icon: FontAwesomeIcons.solidMessage,
                                                  label: "Go To Chat",
                                                )
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  top: MediaQuery.of(context).padding.top+2,
                                                  bottom: MediaQuery.of(context).padding.top+2),
                                              child: ListTile(
                                                leading:const CircleAvatar(
                                                    child: Icon(
                                                        CupertinoIcons
                                                            .heart)),
                                                title: text(
                                                    state.list![index]
                                                        .groupName
                                                        .toString(),
                                                    FontWeight.normal,
                                                    20.0,
                                                    Colors.blue),
                                                subtitle: text(
                                                    "Description",
                                                    FontWeight.normal,
                                                    12.0,
                                                    Colors.blue),
                                                trailing:const Icon(Icons.format_align_justify),
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20.0)),
                                                onTap: () {
                                                  OpenDialog(
                                                      state.list![index]);
                                                },
                                              ),
                                            ),
                                          ));
                                    });
                              } else if (state is CreateGroupErrorState) {
                                return const Center(
                                    child: Text(
                                        "Oops,Something went wrong"));
                              }
                            }

                            return Container();
                          },
                        ),
                      ),
                    ],
                  ):Container(),

                ],
              ),
            ),
          ),
        )
    );
  }
  DepartmentCallBackFunction(newValue) {
    setState(() {
      searchdepID=newValue;
    });
  }

  SearchSemesterCallBackFunction(newValue) {
    setState(() {
      searchSemesterID=newValue;
    });
  }

  BatchCallBackFunction(newValue) {
    setState(() {
      batchID=newValue;
    });
  }

  Future OpenDialog(CreateGroupModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1/5)
      ),

      scrollable: true,
      content:SizedBox(
        height: MediaQuery.of(context).size.height*(0.35/1.6),
        width: MediaQuery.of(context).size.width*.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text("Department Detail",style: TextStyle(color: Colors.black),),
              ),
              const Divider(
                color: Colors.black26,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Department:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.departmentID}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Semester:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.semesterID}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Batch:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.batchID}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("GroupName:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.groupName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.groupStatus}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),



            ],
          ),
        ),
      )


  ));
}
