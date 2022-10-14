import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_Bloc.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_Event.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/Group_State.dart';
import 'package:university_chatapp2/Models/RequestModels/GroupRequestModel.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';

import '../../Bloc/GroupBloc/Group_Bloc.dart';
import '../../Bloc/GroupBloc/Group_Event.dart';
import '../../Models/RequestModels/CreateGroupModel.dart';
import '../../Utility/Widget/MyNav.dart';
import '../RegisteredBatchStudent/RegisteredUsers.dart';
class GroupsDataTable extends StatefulWidget {
  const GroupsDataTable({Key? key}) : super(key: key);

  @override
  State<GroupsDataTable> createState() => _GroupsDataTableState();
}

class _GroupsDataTableState extends State<GroupsDataTable> {
 CreateGroupBloc? bloc;
  @override
  void initState() {
    bloc=BlocProvider.of<CreateGroupBloc>(context);
    bloc!.add(GetCreateGroupData(""));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisteredUsers())),
        child: Icon(Icons.add),
      ),
      appBar:const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget()),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child:Container(
              margin: const EdgeInsets.only(top: 15,bottom: 5),
              child: text("Here you got Group list:-",FontWeight.normal,18.0,Colors.black38),
            ),
          ),
          Divider(
            indent:20,
            endIndent: 20,
            thickness: 2,
            height: 20,
            color: Colors.orangeAccent,

          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<CreateGroupBloc, CreateGroupStates>(
              builder: (context, state) {
                if(state is CreateGroupLoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                else if (state is CreateGroupShowDataState){

                  return ListView.builder(
                      itemCount: state.list!.length,
                      itemBuilder: (BuildContext context,int index){
                        return   Card(
                            margin: EdgeInsets.only(top:15,left: 10,right: 10),
                            shadowColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            elevation: 10,
                            child:Slidable(

                              startActionPane: ActionPane(
                                motion: DrawerMotion(),
                                //   dismissible: DismissiblePane(onDismissed: (){},),
                                children: [

                                  SlidableAction(
                                    onPressed: (BuildContext context) async {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisteredUsers()));
                                    },
                                    backgroundColor: Color(0xFF21B7CA),
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit_rounded,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              endActionPane:  ActionPane(
                                motion: DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (BuildContext context) async {
                                      DeletePressed(state.list![index].groupId);
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),

                                ],
                              ),

                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      child:Icon(CupertinoIcons.heart)
                                  ),
                                  title: text(state.list![index].groupName!,FontWeight.normal,20.0,Colors.blue),
                                  subtitle:  text("Description",FontWeight.normal,12.0,Colors.blue),
                                  trailing: IconButtonWidget(iconData:CupertinoIcons.text_justify,color:Colors.blue,size: 25.0,onPressed: null,),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  onTap: (){
                                    OpenDialog(state.list![index]);
                                  },
                                ),
                              ),
                            )
                        );
                      }

                  );
                }else if(state is CreateGroupErrorState){
                  return Center(child:Text("Oops,Something went wrong"));
                }

                return Container();

              },

            ),
          )
        ],
      ),
    ),
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),child:navbar2()),
    );
  }
  void DeletePressed(String? GroupID){
      bloc!.add(
          DeleteCreateGroup(
            GroupID
          )
      );
  }
  void OnPressed(int index){
    setState(() {});
  }
Future OpenDialog(CreateGroupModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
  title: Column(
    children: [
      Center(
        child: Text("Group Detail",style: TextStyle(color: Colors.blue),),
      ),
      Divider(
        color: Colors.blue,
        thickness: 1,
      ),
      Row(
        children: [

                /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                Container(
                    margin: EdgeInsets.only(top:5,left: 5),
                    child: Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                Container(
                    margin: EdgeInsets.only(top:5,left: 12),
                    child: Text('${model.groupName}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

        ],
      ),
      Row(
        children: [

          /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
          Container(
              margin: EdgeInsets.only(top:5,left: 5),
              child: Text("Users:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
          Container(
              margin: EdgeInsets.only(top:5,left: 12),
              child: Text('${model.groupName}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

        ],
      ),
      Row(
        children: [

          /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
          Container(
              margin: EdgeInsets.only(top:5,left: 5),
              child: Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
          Container(
              margin: EdgeInsets.only(top:5,left: 12),
              child: Text('${model.groupStatus}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

        ],
      ),


    ],
  ),
));
}
/*
Container(
width: 320,
height: 53,
margin: const EdgeInsets.only(top: 30),
child: ElevatedButton.icon(
onPressed: () {},
icon: Icon(CupertinoIcons.doc),
//icon data for elevated button
label: Text("Select Image"),
style: ButtonStyle(
shape: MaterialStateProperty.all<
    RoundedRectangleBorder>(
RoundedRectangleBorder(
borderRadius: BorderRadius
    .circular(12.0),
side: BorderSide(
color: Colors.white)
)
)
), //label text
)
),*/
