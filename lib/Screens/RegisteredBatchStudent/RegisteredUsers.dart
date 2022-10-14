import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';
import 'package:university_chatapp2/Bloc/RegisterBloc/register_bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/CreateGroupModel.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/SemesterDropDown.dart';
import 'package:university_chatapp2/Utility/Widget/Inkwell.dart';

import '../../Bloc/StudentBloc/student_bloc.dart';
import '../../Bloc/TeacherBloc/Teacher_Bloc.dart';
import '../../Bloc/TeacherBloc/Teacher_Event.dart';
import '../../Bloc/TeacherBloc/Teacher_State.dart';
import '../../Models/RequestModels/StudentRequestModel.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/DropDownWidgets/BatchDropDown.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import '../../Utility/Widget/MyNav.dart';
import '../../Utility/Widget/NavigationBar1.dart';

class RegisteredUsers extends StatefulWidget {
  const RegisteredUsers({Key? key}) : super(key: key);

  @override
  State<RegisteredUsers> createState() => _RegisteredUsersState();
}

class _RegisteredUsersState extends State<RegisteredUsers> {
  TeacherBloc? teacherBloc;
  StudentBloc? studentBloc;
  RegisterGroupBloc? registerGroupBloc;
  var groupNameController = TextEditingController();
  List<String> UserId = [];
  bool value = false;
  var batchID = null;
  bool value1 = false;
  String? status;

  String? semID;

  String? depID;

  var searchdepID;

  var searchSemesterID;

  String? searchTeacherBydepID;
  @override
  void initState() {
    teacherBloc = BlocProvider.of<TeacherBloc>(context);
    teacherBloc!.add(GetTeachersByDepIDEvent(searchTeacherBydepID));
    studentBloc = BlocProvider.of<StudentBloc>(context);
    studentBloc!.add(GetStudentByDepSemBatchEvent(depID: searchdepID,semID: searchSemesterID,batchID: batchID));
    registerGroupBloc = BlocProvider.of<RegisterGroupBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  void customFunction(newString) {
    setState(() {
      status = newString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.14),
          child: AppBar(
            bottom:const TabBar(
              tabs: [
                Tab(
                    icon: Icon(CupertinoIcons.person_circle_fill),
                    text: "TeacherList"),
                Tab(
                    icon: Icon(CupertinoIcons.person_circle_fill),
                    text: "StudentList"),
                Tab(
                    icon: Icon(CupertinoIcons.add_circled_solid),
                    text: "Submit")
              ],
            ),
            leadingWidth: 17,
            iconTheme:const IconThemeData(color: Colors.white),
            /*       leading: GestureDetector(
              onTap: (){},
              child: iconButton(CupertinoIcons.arrow_left_circle_fill, Colors.white, 23),
              */ /*child:IconButtonWidget(iconData: CupertinoIcons.arrow_left_circle_fill,color: Colors.white,)*/ /* ),
            title: ListTileWidget1(title: "Name",subtitle: "Online"),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),
            ],*/
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4.5,),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height*0.32/4,
                      child: DepDD(callbackFunction: (newValue){
                        setState(() {
                          searchTeacherBydepID=newValue;
                        });
                      },)
                  ),
                  (searchTeacherBydepID!=null)?ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/9),
                        child: Center(child: text("Here you got student list:-",FontWeight.normal,18.0,Colors.black38)),
                      ),
                      Divider(
                        indent:20,
                        endIndent: 20,
                        thickness: 2,
                        height: MediaQuery.of(context).size.height*0.1/10,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: BlocBuilder<TeacherBloc, TeacherStates>(
                          builder: (context, state) {
                            if (state is TeacherLoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is TeacherShowData) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: state.list.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      var isAdded = UserId.where(
                                              (data) => data == state.list[index].teacherID);
                                      return Card(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height*0.1/5, left: MediaQuery.of(context).size.height*0.1/6.5, right: MediaQuery.of(context).size.height*0.1/6.5),
                                          shadowColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          color: Colors.white,
                                          elevation: 10,
                                          child: Slidable(
                                            child: Padding(
                                              padding:  EdgeInsets.only(
                                                  top: MediaQuery.of(context).padding.top+2, bottom: MediaQuery.of(context).padding.top+2),
                                              child: ListTile(
                                                leading:const  CircleAvatar(
                                                    child: Icon(CupertinoIcons.heart)),
                                                title: text(
                                                    state.list[index].teacherName
                                                        .toString(),
                                                    FontWeight.normal,
                                                    20.0,
                                                    Colors.blue),
                                                subtitle: text("Description",
                                                    FontWeight.normal, 12.0, Colors.blue),
                                                trailing: Checkbox(
                                                  value:
                                                  isAdded.length > 0 ? true : false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      value = newValue!;
                                                    });
                                                    if (value == true) {
                                                      UserId.add(
                                                          state.list[index].teacherID!);
                                                    } else {
                                                      UserId.remove(
                                                          state.list[index].teacherID!);
                                                    }
                                                  },
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(20.0)),
                                                onTap: () {
                                                  OpenDialog(state.list[index]);
                                                },
                                              ),
                                            ),
                                          ));
                                    }),
                              );
                            } else if (state is TeacherErrorState) {
                              return const  Center(child: Text("Oops,Something went wrong"));
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
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
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
                                  alignment: Alignment.topLeft,
                                  margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                                  child: text("Here you got student list:-",FontWeight.normal,18.0,Colors.black38),
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
                                  child: BlocBuilder<StudentBloc, StudentStates>(
                                    builder: (context, state) {
                                      if (batchID != null) {
                                        if (state is StudentLoadingState) {
                                          return const Center(
                                              child: CircularProgressIndicator());
                                        } else if (state is StudentRecordState) {
                                          return ListView.builder(
                                              itemCount: state.list.length,
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
                                                              state.list[index]
                                                                  .studentName
                                                                  .toString(),
                                                              FontWeight.normal,
                                                              20.0,
                                                              Colors.blue),
                                                          subtitle: text(
                                                              "Description",
                                                              FontWeight.normal,
                                                              12.0,
                                                              Colors.blue),
                                                          trailing: Checkbox(
                                                            value: value1,
                                                            onChanged: (newValue) {
                                                              setState(() {
                                                                value1 =
                                                                newValue!;
                                                              });
                                                              if (value1 == true) {
                                                                UserId.add(state
                                                                    .list[index]
                                                                    .studentID!);
                                                              } else {
                                                                UserId.remove(state
                                                                    .list[index]
                                                                    .studentID!);
                                                              }
                                                              print(UserId);
                                                            },
                                                          ),
                                                          shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20.0)),
                                                          onTap: () {
                                                            OpenDialog1(
                                                                state.list[index]);
                                                          },
                                                        ),
                                                      ),
                                                    ));
                                              });
                                        } else if (state is StudentErrorState) {
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
                  ),
                )),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Form(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4.5,),
                              width: MediaQuery.of(context).size.width * 0.9,
                               height: MediaQuery.of(context).size.height*0.32/4,
                              child: DepDD(callbackFunction: (newValue){
                                setState(() {
                                  depID=newValue;
                                });
                              },)
                            ),
                            Container(
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4.5,),
                              width: MediaQuery.of(context).size.width * 0.9,
                               height: MediaQuery.of(context).size.height*0.32/4,
                              child: SemesterDropDown(callbackFunction: (newValue){
                                setState(() {
                                  semID=newValue;
                                });
                              },),
                            ),
                            Container(
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4.5,),
                              width: MediaQuery.of(context).size.width * 0.9,
                              // height: MediaQuery.of(context).size.height*0.32/4,
                              child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                        "Kindly,Enter GroupName here..."),
                                    PatternValidator(r'^[A-Za-z]',
                                        errorText: "Only,letters are allowed")
                                  ]),
                                  controller: groupNameController,
                                  decoration: buildInputDecoration(
                                      "GroupName", 1, false)),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height *
                                    0.32 /
                                    4,
                                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4.5,),
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon:const Icon(CupertinoIcons.doc),
//icon data for elevated button
                                  label:const Text("Select Image"),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                              side:const BorderSide(
                                                  color: Colors
                                                      .white)))), //label text
                                )),

                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height *
                                    0.32 /
                                    4,
                                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4.5,),
                                child: DropDown(
                                  callbackFunction: customFunction,
                                )),

                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
        floatingActionButton: Container(

          margin:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/2.3,),
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: () {
              registerGroupBloc!.add(RegisterGroupEvent(CreateGroupModel(
                  groupName: groupNameController.text,
                  groupStatus: status,
                  groupImage: "",
                  departmentID: depID,
                  semesterID: semID,
                  batchID: batchID,
                  userIds: UserId)));
            },
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
             padding: EdgeInsets.all( MediaQuery.of(context).size.height*0.1/20,),
            child: inKDecoration("Submit"),
          ),
          height: MediaQuery.of(context).size.height * 0.26 / 4,
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme:const IconThemeData(color: Colors.white)),
            child: navbar2()),
      ),
    );
  }

  Future OpenDialog1(StudentRequestModel model) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          scrollable: true,
          content: SizedBox(
            height: MediaQuery.of(context).size.height * (0.41 / 1.5),
            width: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: [
                 const Center(
                    child: Text(
                      "Student Detail",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Divider(
                    color: Colors.blue,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Name:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.studentName}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Department:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.departmentID}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Email:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.studentEmail}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Contact:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.studentContact}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Password:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.studentPassword}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Gender:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.studentGender}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        /* Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: Text(
                              "Status:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              '${model.studentStatus}' == 1
                                  ? "Active"
                                  : "InActive",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )));
  void OnPressed(int index) {
    setState(() {});
  }

  void BatchCallBackFunction(newString) {
    setState(() {
      batchID = newString;
    });
    studentBloc!.add(GetStudentByBatchEvent(ID: batchID));
  }

  Future OpenDialog(TeacherRequestModel model) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          scrollable: true,
          content: Container(
            height: MediaQuery.of(context).size.height * (0.5 / 1.5),
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Teacher Detail",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Name:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.teacherName}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Department:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.depName}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Name:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.teacherName}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Email:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.teacherEmail}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Contact:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.teacherContact}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Password:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.teacherPassword}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            "Gender:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 12),
                          child: Text(
                            '${model.teacherGender}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        /* Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: Text(
                              "Status:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              '${model.teacherStatus}' == 1
                                  ? "Active"
                                  : "InActive",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )));

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
}
