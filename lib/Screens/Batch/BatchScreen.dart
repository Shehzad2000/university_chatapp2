import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:university_chatapp2/Utility/Widget/Inkwell.dart';

import '../../Bloc/BatchBloc/batch_bloc.dart';
import '../../Models/RequestModels/BatchRequestModel.dart';
import '../../Utility/Contraints/Decoration.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import '../../Utility/Widget/MyNav.dart';

class BatchScreen extends StatefulWidget {
  BatchRequestModel? requestModel;
  BatchScreen({Key? key, this.requestModel}) : super(key: key);

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  var BatchID;
  BatchBloc? batchBloc;
  final batchNameController = TextEditingController();
  final StartDateController = TextEditingController();
  final EndDateController = TextEditingController();
  String? status;
  final _formKey = GlobalKey<FormState>();

  void customFunction(newString) {
    setState(() {
      status = newString;
    });
  }

  @override
  void initState() {
    batchBloc = BlocProvider.of<BatchBloc>(context);

    if (widget.requestModel != null) {
      BatchID = widget.requestModel!.batchID;
      batchNameController.text = widget.requestModel!.batchName!;
      StartDateController.text = widget.requestModel!.startDate!;
      EndDateController.text = widget.requestModel!.endDate!;
      status = ((widget.requestModel!.status!) == 1 ? "Active" : "InActive");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<BatchBloc, BatchStates>(
        listener: (context, state) {
          if (state is BatchSuccessState) {
            var snackBar =const SnackBar(
              content: Text(
                'Batch has been registered successfully',
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
                          "Batch Registeration",
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
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.23),
                        child: TextFormField(
                            /*  inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]')),
                                ],*/
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Kindly,Enter Batch Name"),
                              PatternValidator(r'^[A-Za-z0-9]',
                                  errorText: "Only,alphanumeric no is allowed")
                            ]),
                            controller: batchNameController,
                            decoration: buildInputDecoration("Name", 1, false)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                        child: TextFormField(
                            /*  inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]')),
                                ],*/
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Kindly,Enter the Date"),
                              PatternValidator(
                                  r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
                                  errorText:
                                      "Kindly Submit Your Date Pattern correctly")
                            ]),
                            controller: StartDateController,
                            decoration:
                                buildInputDecoration("Start Date", 1, false)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4),
                        child: TextFormField(
                            /*  inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]')),
                                ],*/
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Kindly,Enter the Date"),
                              PatternValidator(
                                  r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
                                  errorText:
                                      "Kindly Submit Your Date Pattern correctly")
                            ]),
                            controller: EndDateController,
                            decoration:
                                buildInputDecoration("EndDate", 1, false)),
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
                              if (_formKey.currentState!.validate()) {
                                if (widget.requestModel == null) {
                                  batchBloc!.add(RegisterBatchEvent(
                                      requestModel: BatchRequestModel(
                                          batchName: batchNameController.text,
                                          startDate: StartDateController.text,
                                          endDate: EndDateController.text,
                                          status: status)));
                                } else {
                                  batchBloc!.add(UpdateBatchEvent(
                                      requestModel: BatchRequestModel(
                                          batchID: BatchID,
                                          batchName: batchNameController.text,
                                          startDate: StartDateController.text,
                                          endDate: EndDateController.text,
                                          status: status)));
                                }
                              }
                            },
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/20),
                            child: inKDecoration((widget.requestModel!=null)?"Update":"Submit")),
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
}
