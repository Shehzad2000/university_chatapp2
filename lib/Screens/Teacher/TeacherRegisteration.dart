import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Bloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Event.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/PositionDropDown.dart';

import '../../Bloc/PositionBloc/Position_Bloc.dart';
import '../../Repo/TeacherRepo.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/Buttons.dart';
import '../../Utility/Widget/DropDownWidgets/DepartmentDropDown.dart';
import '../../Utility/Widget/MyNav.dart';

class TeacherRegisteration extends StatefulWidget {
  TeacherRequestModel? requestModel;
   TeacherRegisteration({Key? key,this.requestModel}) : super(key: key);

  @override
  _TeacherRegisterationState createState() => _TeacherRegisterationState();

}

class _TeacherRegisterationState extends State<TeacherRegisteration> {
  TeacherBloc? teacherBloc;
  PositionBloc? positionBloc;
  var _groupValue;
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final contactController=TextEditingController();
  final imageController=TextEditingController();
  TeacherFireBase teacherFireBase = TeacherFireBase();
  String? departmentID;
String? status;
String? positionID;
final _formKey=GlobalKey<FormState>();
  @override
void initState() {
  teacherBloc=BlocProvider.of<TeacherBloc>(context);
  positionBloc=BlocProvider.of<PositionBloc>(context);

  // TODO: implement initState
  teacherFireBase.GetAllTeachers();

  super.initState();
  }
  @override
  Widget build(BuildContext context) => BlocListener<TeacherBloc, TeacherStates>(
  listener: (context, state) {
    if(state is TeacherSuccessState){
      var snackBar =const SnackBar(
        content: Text('Teacher has been registered successfully',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.elliptical(10, 10),topRight: Radius.elliptical(10, 10))),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar
        /*const SnackBar(content: Text('')),*/
      );
    }else if(state is TeacherErrorState) {
      var snackBar =const SnackBar(
        content: Text('Oops,Something went wrong',style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.redAccent,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.elliptical(10, 10),topRight: Radius.elliptical(10, 10))),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar
      );
    }
    // TODO: implement listener
  },
  child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget(),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.32/4,
                      child: DepDD(callbackFunction: CallbackFunction,)
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                    child: TextFormField(
                      validator:MultiValidator([
                        RequiredValidator(errorText: "Kindly,Enter your name here..."),
                        PatternValidator(r'[a-zA-Z]', errorText: "Only letters are allowed")
                      ]),
                      controller: nameController,
                      decoration: buildInputDecoration("Name", 1, false),
                    ),
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                    child: TextFormField(
                      validator:MultiValidator([
                        RequiredValidator(errorText: "Kindly,Enter your email here..."),
                        EmailValidator(errorText: "Randi k bache,Sahih sai tho dal")
                      ]),
                      controller: emailController,
                      decoration: buildInputDecoration("Email", 1, false),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                    child: TextFormField(
                      validator:MultiValidator([
                        RequiredValidator(errorText: "Kindly,Enter your contact no here..."),
                        MaxLengthValidator(11,errorText: "Kindly,Enter your valid number"),
                        PatternValidator(r'[0-9]', errorText:"Only Digits are allowed,asshole" )
                      ]),
                      controller: contactController,
                      decoration: buildInputDecoration("Contact", 1, false),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.32/4,
                      child: PositionDropDown(callbackFunction: PositionCallBackFunction,)
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5,left: MediaQuery.of(context).size.height*0.1/3),
                    child: const Text(
                      'Gender:',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 19),
                    ),
                  ),
                  SizedBox(
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
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.32/4,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5),
                    child: DropDown(callbackFunction: customFunction,)
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.26 / 4,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/5,bottom: MediaQuery.of(context).size.height*0.1/5),
                    child:

                    MyButton( title:(widget.requestModel==null?"Submit":"Update"),
  onPressed: () {
                           if(_formKey.currentState!.validate()){
                             if(widget.requestModel==null){
                               teacherBloc!.add(RegisterTeacherEvent(TeacherRequestModel(
                                 teacherName: nameController.text,
                                 teacherEmail: emailController.text,
                                 teacherGender: _groupValue,
                                 teacherContact: contactController.text,
                                 departmentID: departmentID,
                                 positionID:positionID,
                                 teacherStatus: status=="Active"?1:0,

                               )
                               ));
                             }
                           }

    }),
                  ),
                ],
              ),
            ),
          ),
        ),
    bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()),
      ),
);
  void PositionCallBackFunction(newString){
    setState(() {
      positionID=newString;
    });
  }
  void customFunction(newString) {
    setState(() {
      status = newString;
    });
  }
  void CallbackFunction(newString) {
    setState(() {
      departmentID = newString;
    });
  }
}
