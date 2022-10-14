import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/StudentBloc/student_bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/StudentRequestModel.dart';
import 'package:university_chatapp2/Utility/Contraints/Decoration.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import 'package:university_chatapp2/Utility/Widget/Inkwell.dart';

import '../../Utility/Widget/DropDownWidgets/BatchDropDown.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../../Utility/Widget/DropDownWidgets/SemesterDropDown.dart';
import '../../Utility/Widget/MyNav.dart';
import '../../Utility/Widget/NavigationBar1.dart';

class StudentRegisteration extends StatefulWidget {
  const StudentRegisteration({Key? key}) : super(key: key);

  @override
  _StudentRegisterationState createState() => _StudentRegisterationState();
}

class _StudentRegisterationState extends State<StudentRegisteration> {
  StudentBloc? studentBloc;
  final rollNoController = TextEditingController();
  var batch;
  dynamic _groupValue;
  String? departmentID;
  String? batchID;
  String? semesterID;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  dynamic status;
  dynamic snackBar;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    studentBloc = BlocProvider.of<StudentBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<StudentBloc, StudentStates>(
        listener: (context, state) {
          if (state is StudentSuccessState) {
            snackBar = const SnackBar(
              content: Text(
                'Student have been registered successfully',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(10, 10),
                      topRight: Radius.elliptical(10, 10))),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar
                /*const SnackBar(content: Text('')),*/
                );
          } else if (state is StudentErrorState) {
            snackBar = const SnackBar(
              content: Text(
                'Oops,Something went wrong',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(10, 10),
                      topRight: Radius.elliptical(10, 10))),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          // TODO: implement listener
        },
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
              child:const AppBarWidget(),
            ),
          /*AppBar(
      leading: GestureDetector(
        onTap: (){},
        child:const Icon(Icons.menu),
      ),
      title:const Text("RegisterationForm"),
      actions: [
        Padding(
            padding:const EdgeInsets.only(right: 20.0),
            child:GestureDetector(
              onTap: (){},
              child:const Icon(Icons.search),
            )
        ),
        Padding(
          padding:const EdgeInsets.only(right:20.0) ,
          child: GestureDetector(
            onTap: (){},
            child:const Icon(Icons.more_vert),
          ),
        )
      ],
    )*/

          body: SingleChildScrollView(
            child: Form(
              child: Center(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.32 / 4,
                        child: DepDD(
                            callbackFunction: DepartmentCallbackFunction)),
                              Container(
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.32/4,
                  child:SemesterDropDown(callbackFunction: SemesterCallbackFunction,)
              ),
                    Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.32 / 4,
                        child:
                            BatchDD(callbackFunction: BatchCallBackFunction)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Kindly,Enter your name here..."),
                          PatternValidator(r'[A-Za-z]',
                              errorText: "Randi k bache,Sahih sai tho dal")
                        ]),
                        controller: nameController,
                        decoration: buildInputDecoration("Name", 1, false),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Kindly,Enter your email"),
                          EmailValidator(
                              errorText: "Randi k bache,Sahih sai tho dal")
                        ]),
                        controller: emailController,
                        decoration: buildInputDecoration("Email", 1, false),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                      child: TextFormField(
                        controller: contactController,
                        decoration: buildInputDecoration("Contact", 1, false),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.32 / 4,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                      child: TextFormField(
                        controller: rollNoController,
                        decoration: buildInputDecoration("RollNo", 1, false),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5,left: MediaQuery.of(context).size.height*0.1/3),
                      child: const Text(
                        'Gender:',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 19),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: "Male",
                              groupValue: _groupValue,
                              title: const Text(
                                "Male",
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 17),
                              ),
                              onChanged: (newValue) =>
                                  setState(() => _groupValue = newValue),
                              activeColor: Colors.lightBlueAccent,
                              selected: false,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: "Female",
                              groupValue: _groupValue,
                              title: const Text("Female",
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 17)),
                              onChanged: (newValue) =>
                                  setState(() => _groupValue = newValue),
                              activeColor: Colors.lightBlueAccent,
                              selected: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.32 / 4,
                        child:
                            DropDown(callbackFunction: StatusCallBackFunction)),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.26 / 4,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5,bottom: MediaQuery.of(context).size.height*0.1/5),
                      child: RaisedButton(
                        onPressed: () {
                          studentBloc!
                              .add(RegisterStudentEvent(StudentRequestModel(
                            studentName: nameController.text,
                            studentEmail: emailController.text,
                            studentGender: _groupValue,
                            studentContact: contactController.text,
                            departmentID: departmentID,
                            semesterID: semesterID,
                            studentStatus: status == "Active" ? 1 : 0,
                          )));
                        },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                        child:inKDecoration("SignUp")
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(iconTheme:const IconThemeData(color: Colors.white)),
              child: navbar2()),
        ),
      );
  void DepartmentCallbackFunction(newString) {
    setState(() {
      departmentID = newString;
    });
  }

  void SemesterCallbackFunction(newString) {
    setState(() {
      semesterID = newString;
    });
  }

  void StatusCallBackFunction(newString) {
    setState(() {
      status = newString;
    });
  }

  void BatchCallBackFunction(newString) {
    setState(() {
      batchID = newString;
    });
  }
}
