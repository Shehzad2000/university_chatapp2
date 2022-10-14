// ignore_for_file: file_names
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpbloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Event.dart';
import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Screens/Admin/AdminRegisteration.dart';

import '../../Bloc/AdminBloc/SignUpEvent.dart';
import '../../Bloc/AdminBloc/SignUpState.dart';

import '../../Bloc/StudentBloc/student_bloc.dart';
import '../../Bloc/TeacherBloc/Teacher_Bloc.dart';
import '../../Models/RequestModels/StudentRequestModel.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/Inkwell.dart';
import '../../Utility/Widget/SocialMediaButtons.dart';
import '../Student/StudentLogin.dart';
import '../Teacher/TeacherLogin.dart';
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final usernameContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  final contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignUpBloc? signUpBloc;
  dynamic snackBar;

  StudentBloc? studentBloc;

  TeacherBloc? teacherBloc;

  bool teacherValue=false;
  bool studentValue=false;
  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    (teacherValue==true)?(studentBloc=BlocProvider.of<StudentBloc>(context)):(teacherBloc=BlocProvider.of<TeacherBloc>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SingUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            snackBar = const SnackBar(
              content: Text(
                'You have been Login successfully',
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
          } else if (state is SignUpErrorState) {
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
            // TODO: implement listener
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
              reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: decorationImage()),
                  Container(
                    margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1/1.8, ),
                    child: Center(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height*.1/1.5,
                        backgroundColor: Colors.white70,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height*.1/1.6,
                         backgroundColor: Colors.black,
                          backgroundImage:const AssetImage('assets/images/z.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.11),
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: MediaQuery.of(context).padding.left+2),
                    child:  ListTile(
                      title:const Text(
                        'Welcome to the',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.lightBlueAccent,
                            shadows: [
                              Shadow(
                                  color: Colors.grey,
                                  offset: Offset(5, 5),
                                  blurRadius: 10),
                            ]),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/15,left: MediaQuery.of(context).size.height*0.1/3),
                        child: const Text(
                          "University ChatApp",
                          style: TextStyle(fontSize: 21, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.53),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Kindly,Enter your email"),
                                  EmailValidator(
                                      errorText:
                                          "Randi k bache,Sahih sai tho dal")
                                ]),
                                controller: usernameContoller,
                                decoration:
                                    buildInputDecoration("Email", 0, true),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                              child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            "Kindly,Enter your password"),
                                    MinLengthValidator(6,
                                        errorText:
                                            "Your Password should be atleast 6 digit")
                                  ]),
                                  controller: passwordContoller,
                                  decoration: buildInputDecoration1(
                                      "Password", 0, true, true)),
                            ),
                            SizedBox(child: inkWellWidget()),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * .1/7),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.26 / 4,
                              child: RaisedButton(
                                  onPressed: () {

  if (_formKey.currentState!.validate()) {
  if(teacherValue==false&&studentValue==false){signUpBloc!.add(SignInAdminEvent(
  AdminRequestModel(
  adminEmail:
  usernameContoller.text,
  adminPassword:
  passwordContoller.text)));}
  else if(teacherValue==true)
  {
    teacherBloc!.add(TeacherLoginEvent(TeacherRequestModel(
        teacherEmail: usernameContoller.text,
        teacherPassword: passwordContoller.text
    )));
  }
  }else if(studentValue==true) {
    studentBloc!.add(StudentSignInEvent(StudentRequestModel(
        studentEmail: usernameContoller.text,
        studentPassword: passwordContoller.text
    )));


  }
                                  }  ,

                                     shape: RoundedRectangleBorder(
                                       borderRadius:
                                         BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                                  child: inKDecoration("SignIn")),
                            ),
                          /*  Container(
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/6),
                              height: MediaQuery.of(context).size.height*0.1/4,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                 //       margin: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/4.5),
                                        child: Checkbox(
                                          value: teacherValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              teacherValue = newValue!;
                                            });
                                          },
                                        ), //Checkbox,,
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                                        alignment: Alignment.bottomCenter,
                                        child: text("isTeacher",FontWeight.normal,18.0,Colors.white),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                               //         margin: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/3.5),
                                        child: Checkbox(
                                          value: studentValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              studentValue = newValue!;

                                            });
                                          },
                                        ), //Checkbox,,
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                                        alignment: Alignment.bottomCenter,
                                        child: text("isStudent",FontWeight.normal,18.0,Colors.white),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                    //    margin: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/3.5),
                                        child: Checkbox(
                                          value: studentValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              studentValue = newValue!;

                                            });
                                          },
                                        ), //Checkbox,,
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                                        alignment: Alignment.bottomCenter,
                                        child: text("Guest",FontWeight.normal,18.0,Colors.white),
                                      ),

                                    ],
                                  ),


                                ],
                              ),
                            ),*/
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
  children: [
    GestureDetector(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/6,left: 0),
              child:socialButtons(FontAwesomeIcons.chalkboardTeacher,context)
          ),
          SizedBox(
            child: text("Teacher",FontWeight.normal,18.0,Colors.white),
          )
        ],
      ),
      onTap: (){
        teacherValue=true;
      },
    ),
    GestureDetector(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/6,left: 0),
              child:socialButtons(FontAwesomeIcons.userGraduate,context)
          ),
          SizedBox(
            child: text("Student",FontWeight.normal,18.0,Colors.white),
          )
        ],
      ),
      onTap: (){
        studentValue=true;
      },
    ),
    GestureDetector(
      child: Column(
        children: [
          Container(

              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/6,left: 0),
              child:socialButtons(FontAwesomeIcons.userFriends,context)
          ),
          SizedBox(
            child: text("Guest",FontWeight.normal,18.0,Colors.white),
          )
        ],
      ),
      onTap: (){

      },
    ),

  ],
  ),
                            /*GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8),
                                alignment: Alignment.bottomCenter,
                                  child: Center(
                                      child: text(
                                          "Dont you have an account?SignUp:-",
                                          FontWeight.normal,
                                          17.0,
                                          Colors.white))),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                       const AdminRegisteration()));
                              },
                            ),*/
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
