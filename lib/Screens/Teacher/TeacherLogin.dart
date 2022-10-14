import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Bloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Event.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Screens/Student/StudentLogin.dart';
import 'package:university_chatapp2/Utility/Contraints/Decoration.dart';
import 'package:university_chatapp2/Utility/Widget/Inkwell.dart';

import '../../Bloc/TeacherBloc/Teacher_State.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Custom_Clippers/Login_Clipper.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  TeacherBloc? Bloc;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool teacherValue=false;
  bool studentValue=false;

  @override
  void initState() {
    Bloc = BlocProvider.of<TeacherBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherBloc, TeacherStates>(
      listener: (context, state) {
        if (state is TeacherSuccessState) {
          var snackBar = const SnackBar(
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
        } else if (state is TeacherErrorState) {
          var snackBar =const SnackBar(
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
          resizeToAvoidBottomInset: true,
          body: Stack(children: [
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                //  color: Colors.blue,
                decoration:const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/B6.jpg'),
                        fit: BoxFit.fill)),
              ),
              clipper: Login_ClipPath(),
            ),
            SingleChildScrollView(
              reverse: true,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.47),
                        child: const Text(
                          'Login_Form',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                        )),
                  ),
                  UnconstrainedBox(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/4 ),
                        child: TextFormField(
                          style:const TextStyle(
                            color: Colors.indigo
                          ),
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
                    ),
                  ),
                  UnconstrainedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.32 / 4,
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.1/8),
                      child: TextFormField(
                        style:const TextStyle(
                            color: Colors.indigo
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Kindly,Enter your Password"),
                          MinLengthValidator(6,
                              errorText:
                                  "Password should be at least 6 characters")
                        ]),
                        controller: passwordController,
                        decoration:
                            buildInputDecoration1("password", 1, false, true),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin:  EdgeInsets.only(
                        top:MediaQuery.of(context).size.height*.1/9,
                      ),
                      child: InkWell(
                          child: const Text('Forget Password',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              )),
                          onTap: () => ('')),
                    ),
                  ),
                  UnconstrainedBox(
                    child: Container(
                      margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/ 8),
                      height: MediaQuery.of(context).size.height * 0.26 / 4,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Bloc!.add(RegisterTeacherEvent(TeacherRequestModel(
                                teacherEmail: emailController.text,
                                teacherPassword: passwordController.text)));
                          }
                        },
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                        child: inKDecoration("SignIn"),
                      ),
                    ),
                  ),


                /*  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Center(child: text("Dont you have an account?SignUp:-",FontWeight.normal,17.0,Colors.blue))),
             */     /*   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin:const EdgeInsets.only(top: 22),
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 33,
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(EvaIcons.twitter,size: 30,),
                            ),
                          ),
                        ),
                        Container(
                          margin:const EdgeInsets.only(top: 22,left: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 33,
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(EvaIcons.facebook,size: 30,),
                            ),
                          ),
                        ),
                        Container(
                          margin:const EdgeInsets.only(top: 22,left: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 33,
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(EvaIcons.google,size: 30,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(child: text("Dont you have an account?SignUp:-",FontWeight.normal,17.0,Colors.blue))),*/
                ],
              ),
            )
          ])),
    );
  }
}
