// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_Bloc.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_Event.dart';
import 'package:university_chatapp2/Models/RequestModels/SemesterRequestModel.dart';
import 'package:university_chatapp2/Utility/Widget/Inkwell.dart';
import 'package:university_chatapp2/Utility/Widget/MyNav.dart';

import '../../Bloc/SemesterBloc/Semester_State.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';


class Semester extends StatefulWidget {
  SemesterRequestModel? requestModel;
  Semester({Key? key, this.requestModel}) : super(key: key);

  @override
  _SemesterState createState() => _SemesterState();
}

class _SemesterState extends State<Semester> {
  dynamic semesterID;
  SemesterBloc? Bloc;
  String? status;
  final semesterController = TextEditingController();
  dynamic snackBar;
  @override
  void initState() {
    Bloc = BlocProvider.of<SemesterBloc>(context);
    if (widget.requestModel != null) {
      semesterID = widget.requestModel!.semesterID;
      semesterController.text = widget.requestModel!.semesterName!;
      status =
          ((widget.requestModel!.semesterStatus!) == 1 ? "Active" : "InActive");
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<SemesterBloc, SemesterStates>(
        listener: (context, state) {
          if (state is SemesterSuccessState) {
            snackBar = const SnackBar(
              content: Text(
                'Semester been registered successfully',
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
          } else if (state is SemesterErrorState) {
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
          resizeToAvoidBottomInset: true,
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
            child:const AppBarWidget(),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
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
                          "Employee Department",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Form(
                        child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.32 / 4,
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.33),
                          child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Enter Semeseter,Asshole"),
                                PatternValidator(r'^[A-Za-z]',
                                    errorText: "Enter String Value,Catamite")
                              ]),
                              controller: semesterController,
                              decoration:
                                  buildInputDecoration("Name", 1, false)),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height:
                                MediaQuery.of(context).size.height * 0.32 / 4,

                            margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                            child: DropDown(
                              callbackFunction: CustomFunction,
                            )),
                         SizedBox(
                            height: MediaQuery.of(context).size.height*.1/7,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.26 / 4,
                            child: RaisedButton(
                              onPressed: () {
                                if (widget.requestModel == null) {
                                  Bloc!.add(AddSemesterEvent(
                                      SemesterRequestModel(
                                          semesterName: semesterController.text,
                                          semesterStatus:
                                              (status == "Active" ? 1 : 0))));
                                } else {
                                  Bloc!.add(UpdateSemesterEvent(
                                      SemesterRequestModel(
                                          semesterID: semesterID,
                                          semesterName: semesterController.text,
                                          semesterStatus:
                                              (status == "Active" ? 1 : 0))));
                                }
                              },
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                              child:inKDecoration("Submit")
                            )
                            /*MyButton(title:"Submit",onPressed: () {
                          Bloc!.add(AddSemesterEvent(SemesterRequestModel(
                              semesterName: semesterController.text,
                              semesterStatus: status=="Active"?1:0
                          )));
                        },)*/

                            ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
           bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()),
        ),
      );

  CustomFunction(newString) {
    setState(() {
      status = newString;
    });
  }
}
