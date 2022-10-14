import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Bloc.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Event.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_State.dart';
import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';
import 'package:university_chatapp2/Utility/Contraints/Decoration.dart';
import 'package:university_chatapp2/Utility/Widget/Buttons.dart';

import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import '../../Utility/Widget/MyNav.dart';
import '../../Utility/Widget/NavigationBar1.dart';

class EmployeePosition extends StatefulWidget {
  PositionRequestModel? requestModel;
  EmployeePosition({Key? key,this.requestModel}) : super(key: key);

  @override
  _EmployeePositionState createState() => _EmployeePositionState();
}

class _EmployeePositionState extends State<EmployeePosition> {
  PositionBloc? positionBloc;
  final positionController = TextEditingController();
  String? status;
  var positionID;
  @override
  void initState() {
    positionBloc=BlocProvider.of<PositionBloc>(context);
    if(widget.requestModel!=null){
      positionID=widget.requestModel!.positionID;
      positionController.text=widget.requestModel!.positionName!;
      status=widget.requestModel!.positionStatus==1?"Active":"InActive";
    }
    // TODO: implement initState
    super.initState();
  }



    @override
    Widget build(BuildContext context) =>
        BlocListener<PositionBloc, PositionStates>(
  listener: (context, state) {
    if(state is PositionSuccessState){
      var snackBar =const SnackBar(
        content: Text('Position been registered successfully',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.elliptical(10, 10),topRight: Radius.elliptical(10, 10))),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar
        /*const SnackBar(content: Text('')),*/
      );
    }else if(state is PositionErrorState) {
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
          resizeToAvoidBottomInset: true,
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.14),
            child:const AppBarWidget(),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .7,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/15,left: MediaQuery.of(context).size.height*0.1/1.4),
                        child: const Text(
                          "Employee Position",
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
                              /* height: MediaQuery.of(context).size.height*0.32/4,*/
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.33),
                              child: TextFormField(
                                 validator: MultiValidator([
                                    RequiredValidator(errorText: "Kindly,Enter Employee Position here..."),
                                    PatternValidator(r'^[A-Za-z]', errorText: "Only,letters are allowed")
                                  ]),
                                  decoration: buildInputDecoration(
                                      "Name", 1, false)
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.32 / 4,
                                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                                child: DropDown(
                                  callbackFunction: customFunction,)
                            ),


                             SizedBox(
                                height: MediaQuery.of(context).size.height*.1/7
                            ),

                            SizedBox(
                                height: MediaQuery.of(context).size.height*0.26/4,
                              child:(widget.requestModel==null)?MyButton(title: "Submit", onPressed: () {
                                   positionBloc!.add(AddPositionEvent(PositionRequestModel(
                                       positionName: positionController.text,
                                       positionStatus: status=="Active"?1:0
                                   )));

                                },):MyButton(title: "Update", onPressed: () {
                                positionBloc!.add(UpdatePositionEvent(PositionRequestModel(
                                positionID: positionID,
                                positionName: positionController.text,
                                positionStatus: status=="Active"?1:0
                                )));


                              },)

                            ),


                          ],

                        )

                    ),
                  )
                ],

              ),

            ),
          ),
    bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()),
  ),
);

  customFunction(newString) {
      setState(() {
        status = newString;
      });
  }
}

//[Colors.brown, Colors.amber