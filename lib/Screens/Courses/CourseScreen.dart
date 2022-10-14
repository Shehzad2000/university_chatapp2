import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Models/RequestModels/CourseRequestModel.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/MyNav.dart';

import '../../Bloc/CoursesBloc/course_bloc.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import '../../Utility/Widget/Inkwell.dart';
class CourseScreen extends StatefulWidget {
  CourseRequestModel? requestModel;
  CourseScreen({Key? key,this.requestModel}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  var courseCodeController=TextEditingController();

  final _formKey=GlobalKey<FormState>();

  String? status;

  var creditHoursController=TextEditingController();

  var courseNameController=TextEditingController();

  String? courseID;

  CourseBloc? courseBloc;

  @override
  void initState() {
    courseBloc=BlocProvider.of<CourseBloc>(context);

    if(widget.requestModel!=null){
    courseID=widget.requestModel!.courseId!;
    courseNameController.text=widget.requestModel!.courseName!;
    creditHoursController.text=widget.requestModel!.totalCreditHours!;
    status=widget.requestModel!.status;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<CourseBloc, CourseStates>(
    listener: (context, state) {
      if (state is CourseSuccessState) {
        var snackBar =const SnackBar(
          content: Text(
            'Course has been registered successfully',
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
      }
      // TODO: implement listener
    },
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.14),
        child:const AppBarWidget(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/15,left: MediaQuery.of(context).size.height*0.1/2),
                    child: const Text(
                      "Course Registeration",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        /* height: MediaQuery.of(context).size.height*0.32/4,*/
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.23),
                        child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Kindly,Enter CourseCode here..."),
                              PatternValidator(r'^[0-9]',
                                  errorText: "Only,digits are allowed")
                            ]),
                            controller: courseCodeController,
                            decoration: buildInputDecoration("Course Code", 1, false)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        /* height: MediaQuery.of(context).size.height*0.32/4,*/
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                        child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Kindly,Enter CourseName here..."),
                              PatternValidator(r'^[a-zA-z]',
                                  errorText: "Only,letters are allowed")
                            ]),
                            controller: courseNameController,
                            decoration: buildInputDecoration("Course Name", 1, false)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        /* height: MediaQuery.of(context).size.height*0.32/4,*/
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                        child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Kindly,Enter Total CreditHours here..."),
                              PatternValidator(r'^[0-9]',
                                  errorText: "Only,digits are allowed")
                            ]),
                            controller: creditHoursController,
                            decoration: buildInputDecoration("Credit Hours", 1, false)),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.32 / 4,
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                          child: DropDown(
                            callbackFunction: customFunction,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1 / 7,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1/10),
                        child: RaisedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              (widget.requestModel!=null)?(courseBloc!.add(UpdateCourseEvent(CourseRequestModel(
                                  courseId: courseID,
                                  courseName: courseNameController.text,
                                  courseCode: courseCodeController.text as int,
                                  totalCreditHours: creditHoursController.text,
                                  status: status
                              )))):(courseBloc!.add(RegisterCourseEvent(CourseRequestModel(
                                courseName: courseNameController.text,
                                courseCode: courseCodeController.text as int,
                                totalCreditHours: creditHoursController.text,
                                status: status,
                              ))));
                            }
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                          child: inKDecoration((widget.requestModel!=null)?"Update":"Submit"),
                        ),
                        height: MediaQuery.of(context).size.height * 0.45 / 7,
                      )
                    ]),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme:const IconThemeData(color: Colors.white)),
          child: navbar2()),
    ),
  );

  customFunction(newValue) {
  setState(() {
    status=newValue;
  });
  }
}
