/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:university_chatapp2/Screens/Student/DataTable/SlideableListView.dart';

import '../../Bloc/StudentBloc/student_bloc.dart';
import '../../Models/RequestModels/StudentRequestModel.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/DropDownWidgets/BatchDropDown.dart';
import '../../Utility/Widget/IconButtons.dart';
import '../../Utility/Widget/NavigationBar1.dart';
class RegisteredBatchStudents extends StatefulWidget {
  const RegisteredBatchStudents({Key? key, required Function(List<String> list2) callbackFunction}) : super(key: key);

  @override
  State<RegisteredBatchStudents> createState() => _RegisteredBatchStudentsState();
}

class _RegisteredBatchStudentsState extends State<RegisteredBatchStudents> {
  var batchID=null;
  StudentBloc? studentBloc;
  bool value = false;
  List<String> studentId = [];
  void initState() {
    studentBloc=BlocProvider.of<StudentBloc>(context);
studentBloc!.add(GetStudentByBatchEvent(ID: batchID));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
 SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              children: [
               Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width*0.89,
                    height: 60,
                    child:BatchDD(callbackFunction:BatchCallBackFunction)
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width*0.89,
                  height:MediaQuery.of(context).size.height,
                  child: BlocBuilder<StudentBloc, StudentStates>(
                    builder: (context, state) {
                    if(batchID!=null){
                      if(state is StudentLoadingState){
                        return Center(child: CircularProgressIndicator());
                      }
                      else if (state is StudentRecordState){

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
                                          onPressed: null,
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
                                            DeletePressed(state.list[index].studentID);
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
                                        title: text(state.list[index].studentName.toString(),FontWeight.normal,20.0,Colors.blue),
                                        subtitle:  text("Description",FontWeight.normal,12.0,Colors.blue),
                                        trailing:  Checkbox(
                                          value: this.value,
                                          onChanged: (newValue) {
                                            setState(() {
                                              this.value = newValue!;
                                            });
                                            if(value == true){
                                              studentId.add(state.list[index].studentID!);
                                            }else{
                                              studentId.remove(state.list[index].studentID!);

                                            }
                                            print(studentId);

                                          },
                                        ),
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
                      }else if(state is StudentErrorState){
                        return Center(child:Text("Oops,Something went wrong"));
                      }
                    }

                      return Container();

                    },

                  ),
                ),


              ],
            ),
          ),
        ),
      ),


    );
  }
  void DeletePressed(String? studentID){
    studentBloc!.add(
        DeleteStudentRecordEvent(
            ID: studentID
        )
    );
  }
  Future OpenDialog(StudentRequestModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),

      scrollable: true,
      content:Container(
        height: MediaQuery.of(context).size.height*(0.45/1.5),
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text("Student Detail",style: TextStyle(color: Colors.black),),
              ),
              Divider(
                color: Colors.black26,
              ),
              Row(
                children: [
                  */
/*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                  Container(
                      margin: EdgeInsets.only(top:5,left: 5),
                      child: Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin: EdgeInsets.only(top:5,left: 12),
                      child: Text('${model.studentName}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                ],
              ),
              Row(
                children: [
                  */
/*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                  Container(
                      margin: EdgeInsets.only(top:5,left: 5),
                      child: Text("Department:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin: EdgeInsets.only(top:5,left: 12),
                      child: Text('${model.departmentID}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                ],
              ),
              Row(
                children: [
                  */
/*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                  Container(
                      margin: EdgeInsets.only(top:5,left: 5),
                      child: Text("Email:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin: EdgeInsets.only(top:5,left: 12),
                      child: Text('${model.studentEmail}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                ],
              ),
              Row(
                children: [
                  */
/*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                  Container(
                      margin: EdgeInsets.only(top:5,left: 5),
                      child: Text("Contact:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin: EdgeInsets.only(top:5,left: 12),
                      child: Text('${model.studentContact}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                ],
              ),
              Row(
                children: [
                  */
/*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                  Container(
                      margin: EdgeInsets.only(top:5,left: 5),
                      child: Text("Password:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin: EdgeInsets.only(top:5,left: 12),
                      child: Text('${model.studentPassword}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                ],
              ),
              Row(
                children: [
                  */
/*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                  Container(
                      margin: EdgeInsets.only(top:5,left: 5),
                      child: Text("Gender:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                  Container(
                      margin: EdgeInsets.only(top:5,left: 12),
                      child: Text('${model.studentGender}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                ],
              ),
              GestureDetector(
                onTap: (){},
                child: Row(
                  children: [
                    */
/* Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*//*

                    Container(
                        margin: EdgeInsets.only(top:10,left: 5),
                        child: Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin: EdgeInsets.only(top:10,left: 10),
                        child: Text('${model.studentStatus}'==1?"Active":"InActive",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),))
                  ],
                ),
              )



            ],
          ),
        ),
      )


  ));
  void OnPressed(int index){
    setState(() {});
  }
  void BatchCallBackFunction(newString){
    setState(() {
      batchID=newString;
    });
    studentBloc!.add(GetStudentByBatchEvent(ID: batchID));
  }
}
*/
