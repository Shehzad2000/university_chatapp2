import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpbloc.dart';
import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';
import 'package:university_chatapp2/Screens/Admin/AdminLogin.dart';
import 'package:university_chatapp2/Utility/Contraints/Decoration.dart';


import '../../Bloc/AdminBloc/SignUpEvent.dart';
import '../../Bloc/AdminBloc/SignUpState.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/Inkwell.dart';

class AdminRegisteration extends StatefulWidget {
  const AdminRegisteration({Key? key}) : super(key: key);

  @override
  _AdminRegisterationState createState() => _AdminRegisterationState();
}

class _AdminRegisterationState extends State<AdminRegisteration> {
  String? groupValue;
  SignUpBloc? signUpBloc;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<SignUpBloc, SingUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            var snackBar =const  SnackBar (
              content:  Text(
                'You have been registered successfully',
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
          body: SingleChildScrollView(
            //  reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: decorationImage()),
                  Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
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
                        child: Stack(
                          children: [
                        /*    Center(
                              child: Center(
                                child: Container(
                                  margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.22),
                                  child: CircleAvatar(
                                    radius: MediaQuery.of(context).size.height*.1/1.6,
                                    backgroundColor: Colors.red,
                                    backgroundImage:
                                       const AssetImage('assets/images/z.jpg'),
                                  ),
                                ),
                              ),
                            ),*/
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                  /*  height: MediaQuery.of(context).size.height *
                                        0.32 /
                                        4,*/
                                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.47),
                                    child: TextFormField(
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  "Kindly,Enter your name"),
                                          PatternValidator(r'^[A-Za-z]',
                                              errorText:
                                                  "Only,letters are allowed")
                                        ]),
                                        controller: nameController,
                                        decoration: buildInputDecoration(
                                            "Name", 0, true)),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                  /*  height: MediaQuery.of(context).size.height *
                                        0.32 /
                                        4,*/
                                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                                    child: TextFormField(
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "Kindly,Enter your email"),
                                        EmailValidator(
                                            errorText:
                                                "Randi k bache,Sahih sai tho dal")
                                      ]),
                                      controller: emailController,
                                      decoration: buildInputDecoration(
                                          "Email", 0, true),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                  /*  height: MediaQuery.of(context).size.height *
                                        0.32 /
                                        4,*/
                                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                                    child: TextFormField(
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "Kindly,Enter your contact no"),
                                        PatternValidator(r'^[0-9]',
                                            errorText:
                                                "Only,Digits are allowed")
                                      ]),
                                      controller: contactController,
                                      decoration: buildInputDecoration(
                                          "Contact", 0, true),
                                    ),
                                  ),
                                  /*      Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            height: MediaQuery.of(context).size.height*0.32/4,
                            margin: const EdgeInsets.only(top: 15),
                            child: MyButton(onPressed: (){},title: "Picture",)
                          ),*/
                                  Container(
                                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4,right: MediaQuery.of(context).size.height*0.32),
                                    child: const Text(
                                      'Gender:',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: RadioListTile(
                                            value: "Male",
                                            groupValue: groupValue,
                                            title:const Text(
                                              "Male",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                            onChanged: (newValue) => setState(
                                                () => groupValue =
                                                    newValue as String?),
                                            activeColor: Colors.white,
                                            selected: false,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: RadioListTile(
                                            value: "Female",
                                            groupValue: groupValue,
                                            title:const Text("Female",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17)),
                                            onChanged: (newValue) => setState(
                                                () => groupValue =
                                                    newValue as String?),
                                            activeColor: Colors.white,
                                            selected: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1 /
                                              10.5),
                                  SizedBox(
                                    // width: MediaQuery.of(context).size.width*0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.26 /
                                        4,
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          signUpBloc!.add(AddAdminEvent(
                                              AdminRequestModel(
                                                  adminName:
                                                      nameController.text,
                                                  adminEmail:
                                                      emailController.text,
                                                  adminContact:
                                                      contactController.text,
                                                  adminGender: groupValue)));
                                        }
                                      },
                                       shape: RoundedRectangleBorder(
                                           borderRadius:
                                               BorderRadius.circular(80.0)),
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                                      child: inKDecoration("SignUp"),
                                    ),
                                  ),
                                  /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:const EdgeInsets.only(top: 15,),
                                child:const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 33,
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Icon(EvaIcons.twitter,size: 30,),
                                  ),
                                ),
                              ),
                              Container(
                                margin:const EdgeInsets.only(top: 15,left: 20),
                                child:const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 33,
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Icon(EvaIcons.facebook,size: 30,),
                                  ),
                                ),
                              ),
                              Container(
                                margin:const EdgeInsets.only(top: 15,left: 20),
                                child:const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 33,
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Icon(EvaIcons.google,size: 30,),
                                  ),
                                ),
                              ),
                            ],
                          ),*/

                                  GestureDetector(
                                    child: Container(
                                        margin:  EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height*0.1/10, left: 0),
                                        child: text(
                                            "Already have an account?SignIn:-",
                                            FontWeight.normal,
                                            17.0,
                                            Colors.white)),
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                               const AdminLoginScreen())),
                                  ),
                                ],
                              ),
                            ),
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
