import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/Group_Bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/GroupRequestModel.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/DropDownWidgets/DropDownWidget.dart';

import '../../Bloc/GroupBloc/Group_Event.dart';
import '../../Bloc/GroupBloc/Group_State.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/Buttons.dart';
import '../../Utility/Widget/NavigationBar1.dart';
class groups extends StatefulWidget {
  GroupRequestModel? requestModel;
   groups({Key? key,this.requestModel}) : super(key: key);

  @override
  State<groups> createState() => _groupState();
}
class _groupState extends State<groups> {
  GroupBloc? groupBloc;
  var groupID;
  var groupName = TextEditingController();
  var image = "";
  String? status;
  void customFunction(newString) {
    setState(() {
      status = newString;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    groupBloc = BlocProvider.of<GroupBloc>(context);
    if (widget.requestModel != null) {
      groupID = widget.requestModel!.groupID;
      groupName.text = widget.requestModel!.groupName!;
      status = ((widget.requestModel!.groupStatus!) == 1
          ? "Active"
          : "InActive");
      super.initState();
    }
  }
    @override
    Widget build(BuildContext context) => BlocListener<GroupBloc, GroupStates>(
  listener: (context, state) {
    if(state is GroupSuccessState){
      final snackBar = SnackBar(
        content: Text('You have been registered successfully',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.elliptical(10, 10),topRight: Radius.elliptical(10, 10))),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar
        /*const SnackBar(content: Text('')),*/
      );
    }else if(state is GroupErrorState) {
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
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget(),
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2,
                  padding: const EdgeInsets.only(top: 50, left: 7),
                  child: const ListTile(
                    title: Text('Welcome to the', style: TextStyle(
                        fontSize: 30,
                        color: Colors.lightBlueAccent,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(5, 5),
                              blurRadius: 10),
                        ]),),
                    subtitle: Text("Employee Position",
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ),
                ),
                Center(
                  child: Form(
                      child: Column(
                        children: [

                          Container(
                            width: 320,
                            margin: const EdgeInsets.only(top: 230),
                            child: TextFormField(
                               validator: MultiValidator([
                                 RequiredValidator(errorText: 'Please Enter GroupName'),
                                 PatternValidator(r'[a-zA-z]', errorText: "Select only string values")
                               ]),
                                controller: groupName,
                                decoration: buildInputDecoration(
                                    "GroupName", 1, false)
                            ),
                          ),
                          Container(
                              width: 320,
                              margin: const EdgeInsets.only(top: 30),
                              child: DropDown(
                                callbackFunction: customFunction,)
                          ),
                          Container(
                              width: 320,
                              height: 53,
                              margin: const EdgeInsets.only(top: 30),
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.doc),
                                //icon data for elevated button
                                label: Text("Select Image"),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(12.0),
                                            side: BorderSide(
                                                color: Colors.white)
                                        )
                                    )
                                ), //label text
                              )
                          ),

                          const SizedBox(
                            height: 25,
                          ),


                          SizedBox(
                              height: 50.0,
                              child:
                              MyButton(title: (widget.requestModel == null
                                  ? "Submit"
                                  : "Update"),
                                  onPressed: () {
                                    if (widget.requestModel == null) {
                                      groupBloc!.add(RegisterGroup(
                                          GroupRequestModel(
                                              groupName: groupName.text,
                                              groupImage: null,
                                              groupStatus: (status == "Active"
                                                  ? 1
                                                  : 0)
                                          )
                                      ));
                                    }else{
                                      groupBloc!.add(UpdateGroupDetails(
                                          GroupRequestModel(
                                              groupID: groupID,
                                              groupName: groupName.text,
                                              groupStatus:
                                              (status == "Active" ? 1 : 0))));
                                    }
                                    /*RaisedButton(
                              onPressed: () {

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: const EdgeInsets.all(4.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xff374ABE),
                                      Color(0xff64B6FF)
                                    ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                                  })),


                        ],

                      )

                  ),
                )
              ],

            ),

          ),
        ),
        bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white)), child: navbar1()),
      ),
);


    }


