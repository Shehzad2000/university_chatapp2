import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Models/RequestModels/CourseRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/RegisterCoursesRequestModel.dart';
import 'package:university_chatapp2/Screens/Courses/CourseScreen.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import 'package:university_chatapp2/Utility/Widget/MyNav.dart';

import '../../Bloc/CoursesBloc/course_bloc.dart';
import '../../Bloc/RegisterCourseBloc/register_course_bloc.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../../Utility/Widget/DropDownWidgets/SemesterDropDown.dart';
import '../../Utility/Widget/IconButtons.dart';
import '../../Utility/Widget/Inkwell.dart';
class RegisterCourses extends StatefulWidget {
  const RegisterCourses({Key? key}) : super(key: key);

  @override
  State<RegisterCourses> createState() => _RegisterCoursesState();
}

class _RegisterCoursesState extends State<RegisterCourses> {
  var _formKey = GlobalKey<FormState>();

  String? depID;

  String? semID;

  String? status;

  CourseBloc? courseBloc;

  RegisterCourseBloc? registerCourseBloc;

  bool value=false;

  List<String>? courseslist=[];

  var course1Controller=TextEditingController();

  var course2Controller=TextEditingController();

  bool search=false;

  @override
  void initState() {
    // TODO: implement initState
    courseBloc = BlocProvider.of<CourseBloc>(context);
    registerCourseBloc=BlocProvider.of<RegisterCourseBloc>(context);
    (search==false)?(courseBloc!.add(ShowAllCourseWithDetailsEvent())):(courseBloc!.add(SearchCourseEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            //  title: Text('Flutter Tabs Demo'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: FaIcon(FontAwesomeIcons.school), text: "Data"),
                Tab(icon: FaIcon(FontAwesomeIcons.book), text: "Courses")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: Center(
                    child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            margin: const EdgeInsets.only(top: 30),
                            child: DepDD(callbackFunction: DepCallBackFunction),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.32 / 4,
                            margin: const EdgeInsets.only(top: 20),
                            child: SemesterDropDown(
                                callbackFunction: semesterCallBackFunction),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.32 / 4,
                            margin: const EdgeInsets.only(top: 20),
                            child: DropDown(
                                callbackFunction: statusCallBackFunction),
                          ),
                        ]))),
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.37,

                              /* height: MediaQuery.of(context).size.height*0.32/4,*/
                              margin: const EdgeInsets.only(top: 30,left: 10),
                              child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Kindly,Enter CourseCode here..."),
                                    PatternValidator(r'^[0-9]',
                                        errorText: "Only,digits are allowed")
                                  ]),
                                  controller: course1Controller,
                                  decoration: buildInputDecoration("Course Code", 1, false)),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.37,
                              /* height: MediaQuery.of(context).size.height*0.32/4,*/
                              margin: const EdgeInsets.only(top: 30,left: 5),
                              child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Kindly,Enter CourseCode here..."),
                                    PatternValidator(r'^[0-9]',
                                        errorText: "Only,digits are allowed")
                                  ]),
                                  controller: course2Controller,
                                  decoration: buildInputDecoration("Course Code", 1, false)),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                               height: MediaQuery.of(context).size.height*0.32/4,
                              margin: const EdgeInsets.only(top: 30,left: 5),
                              child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){courseBloc!.add(
                                      SearchCourseEvent(courseCode1: course1Controller.text,courseCode2: course2Controller.text));
                                    search=true;
                                }
                                  },
                                child: Icon(Icons.search),
                              )
                            ),
                          ],
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: 15, bottom: 5),
                          child: text(
                              "Here you got Courses list:-", FontWeight.normal,
                              18.0, Colors.black38),
                        ),
                        const Divider(
                          indent: 20,
                          endIndent: 20,
                          thickness: 2,
                          height: 20,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child:
                          BlocBuilder<CourseBloc, CourseStates>(
                            builder: (context, state) {
                              if (state is CourseLoadingState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              else if (state is CourseShowDataState) {
                                return ListView.builder(
                                    itemCount: state.list!.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                     /* var isAdded = courses.where(
                                              (data) => data == state.list![index].courseId);*/
                                      return Card(
                                          margin: const EdgeInsets.only(
                                              top: 15, left: 10, right: 10),
                                          shadowColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15.0),
                                          ),
                                          color: Colors.white,
                                          elevation: 10,
                                          child: Slidable(
                                            startActionPane: ActionPane(
                                              motion: const DrawerMotion(),
                                              //   dismissible: DismissiblePane(onDismissed: (){},),
                                              children: [

                                                SlidableAction(
                                                  onPressed: (
                                                      BuildContext context) async {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CourseScreen(
                                                                  requestModel: CourseRequestModel(
                                                                      courseId: state
                                                                          .list![index]
                                                                          .courseId!,
                                                                      status: state
                                                                          .list![index]
                                                                          .status,
                                                                      courseName: state
                                                                          .list![index]
                                                                          .courseName,
                                                                      courseCode: state
                                                                          .list![index]
                                                                          .courseCode),)));
                                                  },
                                                  backgroundColor: const Color(
                                                      0xFF21B7CA),
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.edit_rounded,
                                                  label: 'Edit',
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              motion: const DrawerMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (
                                                      BuildContext context) async {
                                                    DeletePressed(
                                                        state.list![index]
                                                            .courseId);
                                                  },
                                                  backgroundColor: const Color(
                                                      0xFFFE4A49),
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete,
                                                  label: 'Delete',
                                                ),

                                              ],
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0, bottom: 2.0),
                                              child: ListTile(
                                                leading:const CircleAvatar(
                                                    child: Icon(
                                                        CupertinoIcons.heart)
                                                ),
                                                title: text(
                                                    state.list![index].courseName
                                                        .toString(),
                                                    FontWeight.normal, 20.0,
                                                    Colors.blue),
                                                subtitle: text("Description",
                                                    FontWeight.normal, 12.0,
                                                    Colors.blue),
                                                trailing: Checkbox(
                                                  value: value,
                                                  onChanged: (newValue){
                                                    setState(() {
                                                      value=newValue!;
                                                    });
                                                    (value==true)?(courseslist!.add(state.list![index].courseId!)):(courseslist!.remove(state.list![index].courseId));
                                                  },
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(20.0)),
                                                onTap: () {
                                                  OpenDialog(state.list![index]);
                                                },
                                              ),
                                            ),
                                          )
                                      );
                                    }

                                );
                              } else if (state is CourseErrorState) {
                                return Center(
                                    child: Text("Oops,Something went wrong"));
                              }
                              return Container();
                            },

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin:const EdgeInsets.only(left: 40),
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          onPressed: () {
           registerCourseBloc!.add(RegisterMainCourseEvent(RegisterCoursesRequestModel(
             department: depID,
             semester: semID,
             courses: courseslist,
           )));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding:const EdgeInsets.all(4.0),
          child: inKDecoration("Submit"),
        ),
        height: MediaQuery.of(context).size.height * 0.26 / 4,
      ),
      /*bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white)),
          child: navbar2()),
*/
    );
  }

  DepCallBackFunction(newValue) {
    setState(() {
      depID = newValue;
    });
  }

  semesterCallBackFunction(newValue) {
    setState(() {
      semID = newValue;
    });
  }

  statusCallBackFunction(newValue) {
    setState(() {
      status = newValue;
    });
  }

  void DeletePressed(String? ID) {
    courseBloc!.add(
        RemoveCourseEvent(
            ID
        )
    );
  }

  Future OpenDialog(CourseRequestModel model) =>
      showDialog(context: context, builder: (context) =>
          AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),

              scrollable: true,
              content: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * (0.2 / 1.5),
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Text("Course Detail",
                          style: TextStyle(color: Colors.black),),
                      ),
                      const Divider(
                        color: Colors.black26,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 5),
                                child:const Text(
                                  "CourseCode:", style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),)),
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 12),
                                child: Text('${model.courseCode}',
                                  style:const TextStyle(color: Colors.blue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),)),

                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 5),
                                child:const Text(
                                  "CourseName:", style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),)),
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 12),
                                child: Text('${model.courseName}',
                                  style:const TextStyle(color: Colors.blue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),)),

                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 5),
                                child:const Text(
                                  "CreditHours:", style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),)),
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 12),
                                child: Text('${model.totalCreditHours}',
                                  style:const TextStyle(color: Colors.blue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),)),

                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            /* Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                            Container(
                                margin:const EdgeInsets.only(top: 5, left: 5),
                                child:const Text(
                                  "Status:", style: TextStyle(color: Colors
                                    .black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),)),

                            Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text('${model.status}', style:const TextStyle(color: Colors
                                    .blue,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),))
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              )


          ));
}