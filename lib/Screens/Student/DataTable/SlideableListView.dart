import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Utility/Contraints/Text.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';

import '../../../Bloc/StudentBloc/student_bloc.dart';
import '../../../Models/RequestModels/StudentRequestModel.dart';
import '../../../Utility/Widget/MyNav.dart';
class GetAllStudentData extends StatefulWidget {
  String? batchID;
  String? Department;
  String? semID;
  String? showAppBar;
  GetAllStudentData({Key? key,this.batchID,this.Department,this.semID,this.showAppBar}) : super(key: key);

  @override
  State<GetAllStudentData> createState() => _GetAllStudentDataState();
}

class _GetAllStudentDataState extends State<GetAllStudentData> {
 StudentBloc? studentBloc;
  @override
  void initState() {
    studentBloc=BlocProvider.of<StudentBloc>(context);
    (widget.batchID==null)?studentBloc!.add(GetAllStudentRecordEvent()):studentBloc!.add(GetStudentByDepSemBatchEvent(batchID:widget.batchID,depID: widget.Department,semID: widget.semID));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:(widget.batchID==null||widget.showAppBar!=null)? PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget()):null,
      body:
    BlocBuilder<StudentBloc, StudentStates>(
  builder: (context, state) {
    if(state is StudentLoadingState){
      return const Center(child: CircularProgressIndicator());
    }
    else if (state is StudentRecordState){

      return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (BuildContext context,int index){
            return   Card(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/7,right: MediaQuery.of(context).size.height*0.1/7),
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child:Slidable(

                  startActionPane:const ActionPane(
                    motion: DrawerMotion(),
                    //   dismissible: DismissiblePane(onDismissed: (){},),
                    children: [

                      SlidableAction(
                        onPressed: null,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit_rounded,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane:  ActionPane(
                    motion:const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) async {
                            DeletePressed(state.list[index].studentID);
                        },
                        backgroundColor:const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),

                    ],
                  ),

                  child: Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top+2,bottom: MediaQuery.of(context).padding.bottom+2),
                    child: ListTile(
                      leading:const CircleAvatar(
                          child:Icon(CupertinoIcons.heart)
                      ),
                      title: text(state.list[index].studentName.toString(),FontWeight.normal,20.0,Colors.blue),
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
    }else if(state is DepartmentErrorState){
      return const Center(child:Text("Oops,Something went wrong"));
    }

    return Container();

    },

),
      bottomNavigationBar:(widget.showAppBar!=null)?Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()):null,

    );
  }
  void DeletePressed(String? studentID){
      studentBloc!.add(
          DeleteStudentRecordEvent(
            ID: studentID
          )
      );
  }
  void OnPressed(int index){
    setState(() {});
  }
 Future OpenDialog(StudentRequestModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15)
     ),

     scrollable: true,
     content:Container(
       height: MediaQuery.of(context).size.height*(0.45/1.5),
       width: MediaQuery.of(context).size.width*.9,
       child: SingleChildScrollView(
         child: Column(
           children: [
             const Center(
               child: Text("Student Detail",style: TextStyle(color: Colors.black),),
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
                       child:const Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.studentName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: [
                   /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                   Container(
                       margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child:const Text("Batch:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Container(
                         margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                         child: Text('${model.semesterID}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                   ),

                 ],
               ),
             ),
             Row(
               children: [
                 /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                 Container(
                     margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                     child:const Text("Email:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.studentEmail}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                 ),

               ],
             ),
             Row(
               children: [
                 /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                 Container(
                     margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                     child:const Text("Contact:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.studentContact}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                 ),

               ],
             ),
             Row(
               children: [
                 /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                 Container(
                     margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                     child:const Text("Gender:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.studentGender}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                 ),

               ],
             ),
             Row(
               children: [
                 /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                 Container(
                     margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                     child:const Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                       child: Text('${model.studentStatus}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                 ),

               ],
             ),
           ],
         ),
       ),
     )


 ));
}
