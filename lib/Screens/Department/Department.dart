import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_Bloc.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Models/RequestModels/DepartmentRequestModel.dart';

import 'package:university_chatapp2/Utility/Widget/Inkwell.dart';

import '../../Bloc/DepartmentBloc/Department_Event.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import '../../Utility/Widget/MyNav.dart';

class Department extends StatefulWidget {
  DepartmentRequestModel? requestModel;

  Department({Key? key, this.requestModel}) : super(key: key);

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  var departmentID;
  DepartmentBloc? departmentBloc;
  final depNameController = TextEditingController();
  String? status;
  final _formKey = GlobalKey<FormState>();

  void customFunction(newString) {
    setState(() {
      status = newString;
    });
  }

  @override
  void initState() {
    departmentBloc = BlocProvider.of<DepartmentBloc>(context);

    if (widget.requestModel != null) {
      departmentID = widget.requestModel!.departmentID;
      depNameController.text = widget.requestModel!.departmentName!;
      status = ((widget.requestModel!.departmentStatus!) == 1
          ? "Active"
          : "InActive");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<DepartmentBloc,
          DepartmentStates>(
      listener: (context, state) {
        if (state is DepartmentSuccessState) {
          var snackBar =const SnackBar(
            content: Text(
              'Dapartment has been registered successfully',
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
        } else if (state is DepartmentErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Oops,Something went wrong'),
            ),
          );
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      /* height: MediaQuery.of(context).size.height*0.32/4,*/
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.33),
                      child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Kindly,Enter Department here..."),
                            PatternValidator(r'^[A-Za-z]',
                                errorText: "Only,letters are allowed")
                          ]),
                          controller: depNameController,
                          decoration: buildInputDecoration("Name", 1, false)),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.32 / 4,
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                        child: DropDown(
                          callbackFunction: customFunction,
                        )),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .1 / 7),
                    SizedBox(
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.requestModel == null) {
                              departmentBloc!.add(AddDepartmentEvent(
                                  DepartmentRequestModel(
                                      departmentName: depNameController.text,
                                      departmentStatus:
                                          (status == "Active" ? 1 : 0))));
                            } else {
                              departmentBloc!.add(UpdateDepartmentEvent(
                                  DepartmentRequestModel(
                                      departmentID: departmentID,
                                      departmentName: depNameController.text,
                                      departmentStatus:
                                          (status == "Active" ? 1 : 0))));
                            }
                          }
                        },
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                         padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                        child: inKDecoration((widget.requestModel!=null)?"Update":"Submit"),
                      ),
                      height: MediaQuery.of(context).size.height * 0.26 / 4,
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
      ));
}
