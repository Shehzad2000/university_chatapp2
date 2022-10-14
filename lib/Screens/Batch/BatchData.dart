import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university_chatapp2/Bloc/GetUserIdBloc/getuser_id_bloc.dart';
import 'package:university_chatapp2/Screens/Batch/BatchScreen.dart';
import 'package:university_chatapp2/Screens/Student/StudentDetail.dart';

import '../../Bloc/BatchBloc/batch_bloc.dart';
import '../../Models/RequestModels/BatchRequestModel.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/IconButtons.dart';
import '../../Utility/Widget/MyNav.dart';
import '../Student/DataTable/SlideableListView.dart';

class BatchData extends StatefulWidget {
  BatchData({Key? key}) : super(key: key);

  @override
  State<BatchData> createState() => _BatchDataState();
}

class _BatchDataState extends State<BatchData> {
  BatchBloc? batchBloc;
  @override
  void initState() {
    batchBloc = BlocProvider.of<BatchBloc>(context);
    batchBloc!.add(GetAllBatchesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BatchScreen()));
        },
        child:const Icon(Icons.add),
      ),
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.14), child:const AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
              child: Center(child: text("Here you got Batch list:-",FontWeight.normal,18.0,Colors.black38)),
            ),
            Divider(
              indent:20,
              endIndent: 20,
              thickness: 2,
              height: MediaQuery.of(context).size.height*0.1/10,
              color: Colors.orangeAccent,
            ),
            SizedBox(
              //margin: EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<BatchBloc, BatchStates>(
                builder: (context, state) {
                  if (state is BatchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BatchShowDataState) {
                    return ListView.builder(
                        itemCount: state.list!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/7,right: MediaQuery.of(context).size.height*0.1/7),
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              elevation: 10,
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion:const DrawerMotion(),
                                  //   dismissible: DismissiblePane(onDismissed: (){},),
                                  children: [
                                    SlidableAction(
                                      onPressed:
                                          (BuildContext context) async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (context) => BatchScreen(
                                                          requestModel: BatchRequestModel(
                                                              batchID: state
                                                                  .list![
                                                                      index]
                                                                  .batchID!,
                                                              batchName: state
                                                                  .list![
                                                                      index]
                                                                  .batchName!,
                                                              startDate: state
                                                                  .list![
                                                                      index]
                                                                  .startDate,
                                                              endDate: state
                                                                  .list![
                                                                      index]
                                                                  .endDate,
                                                              status: state
                                                                  .list![
                                                                      index]
                                                                  .status),
                                                        )));
                                      },
                                      backgroundColor:const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_rounded,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      onPressed:
                                          (BuildContext context) async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GetAllStudentData(
                                                      batchID: state
                                                          .list![index]
                                                          .batchID,
                                                      showAppBar: "true",
                                                    )));
                                      },
                                      backgroundColor: Colors.orangeAccent,
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.userGraduate,
                                      label: 'Go To',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion:const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed:
                                          (BuildContext context) async {
                                        DeletePressed(
                                            state.list![index].batchID);
                                      },
                                      backgroundColor:const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.only(
                                      top: MediaQuery.of(context).padding.top+2, bottom: MediaQuery.of(context).padding.bottom+2),
                                  child: ListTile(
                                    leading:const CircleAvatar(
                                        child: Icon(CupertinoIcons.heart)),
                                    title: text(
                                        state.list![index].batchName
                                            .toString(),
                                        FontWeight.normal,
                                        20.0,
                                        Colors.blue),
                                    subtitle: text("Description",
                                        FontWeight.normal, 12.0, Colors.blue),
                                    trailing: IconButtonWidget(
                                      iconData: CupertinoIcons.text_justify,
                                      color: Colors.blue,
                                      size: 25.0,
                                      onPressed: null,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onTap: () {
                                      OpenDialog(state.list![index]);
                                    },
                                  ),
                                ),
                              ));
                        });
                  } else if (state is BatchErrorState) {
                    return const Center(child: Text("Oops,Something went wrong"));
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme:const IconThemeData(color: Colors.white)),
          child: navbar2()),
    );
  }

  void DeletePressed(String? ID) {
    batchBloc!.add(RemoveBatchEvent(ID: ID));
  }

  void OnPressed(int index) {
    setState(() {});
  }

  Future OpenDialog(BatchRequestModel model) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          scrollable: true,
          content: SizedBox(
            height: MediaQuery.of(context).size.height * (0.27 / 1.4),
            width: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: [
                 const Center(
                    child: Text(
                      "Batch Detail",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                 const Divider(
                    color: Colors.orangeAccent,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child:const Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                      Container(
                          margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child: Text('${model.batchName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child:const Text("Start-Date:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                      Container(
                          margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child: Text('${model.startDate}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child:const Text("End-Date:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                      Container(
                          margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child: Text('${model.endDate}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                    ],
                  ),
                  Row(
                    children: [
                      /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                      Container(
                          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child:const Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                      Container(
                          margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                          child: Text('${model.status}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                    ],
                  ),
                ],
              ),
            ),
          )));
}
