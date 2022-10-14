import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Event.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Screens/Teacher/TeacherRegisteration.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';

import '../../../Bloc/TeacherBloc/Teacher_Bloc.dart';
import '../../../Utility/Widget/MyNav.dart';
import '../../Department/Department.dart';
class AllTeachersData extends StatefulWidget {
  String? departmentID;
  AllTeachersData({Key? key,this.departmentID}) : super(key: key);

  @override
  State<AllTeachersData> createState() => _AllTeachersDataState();
}

class _AllTeachersDataState extends State<AllTeachersData> {
 TeacherBloc? teacherBloc;
  @override
  void initState() {
    teacherBloc=BlocProvider.of<TeacherBloc>(context);
    (widget.departmentID==null)?teacherBloc!.add(GetAllTeachersDataEvent()):teacherBloc!.add(GetTeachersByDepIDEvent(widget.departmentID));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add), onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Department()));
      },
      ),
      appBar:( widget.departmentID==null?
       PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget()):null),
    body:
    BlocBuilder<TeacherBloc, TeacherStates>(
  builder: (context, state) {
    if(state is TeacherLoadingState){
      return const Center(child: CircularProgressIndicator());
    }
    else if (state is TeacherShowData){

      return ListView.builder(
          itemCount: state.list.length,
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
                        onPressed: (BuildContext context)async{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TeacherRegisteration(
                            requestModel: TeacherRequestModel(
                              teacherID: state.list[index].teacherID,teacherName: state.list[index].teacherName,teacherEmail: state.list[index].teacherEmail,
                              teacherContact: state.list[index].teacherContact,teacherGender: state.list[index].teacherGender,teacherStatus: state.list[index].teacherStatus,
                              departmentID: state.list[index].departmentID,positionID: state.list[index].positionID,registrationDate: state.list[index].registrationDate,
                            ),
                          )));
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
                            DeletePressed(state.list[index].teacherID);
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
                      title: text(state.list[index].teacherName.toString(),FontWeight.normal,20.0,Colors.blue),
                      subtitle:  text("Description",FontWeight.normal,12.0,Colors.blue),
                      trailing: IconButtonWidget(iconData:CupertinoIcons.text_justify,color:Colors.blue,size: 25.0,onPressed: null,),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      onTap: (){
                        OpenDialog(state.list[index]);
                      },
                    ),
                  ),
                )
            );
          }

      );
    }else if(state is TeacherErrorState){
      return Center(child:Text("Oops,Something went wrong"));
    }

    return Container();

    },

),
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),child:navbar2()),
    );
  }
  void DeletePressed(String? TeacherID){
      teacherBloc!.add(
          RemoveTeacherEvent(
            ID: TeacherID
          )
      );
  }
  void OnPressed(int index){
    setState(() {});
  }
 Future OpenDialog(TeacherRequestModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15)
     ),

     scrollable: true,
     content:SizedBox(
       height: MediaQuery.of(context).size.height*(0.48/1.5),
       width: MediaQuery.of(context).size.width*.9,
       child: SingleChildScrollView(
         child: Column(
           children: [
            const Center(
               child: Text("Teacher Detail",style: TextStyle(color: Colors.black),),
             ),
          const   Divider(
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
                       child:const Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.teacherName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
               child:const Text("Department:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
           Container(
               margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
               child: Text('${model.depName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                       child:const Text("Position:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.posName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                   child:const Text("Email:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
               Container(
                   margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                   child: Text('${model.teacherEmail}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                       child:const Text("Contact:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.teacherContact}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                       child:const Text("Gender:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.teacherGender}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                       child:const Text("RegDate:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.registrationDate}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                       child: Text('${model.teacherStatus}'==1?"Active":"InActive",style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                 ],
               ),
             ),



           ],
         ),
       ),
     ),



 ));
}
