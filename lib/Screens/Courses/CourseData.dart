import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Bloc/CoursesBloc/course_bloc.dart';
import '../../Models/RequestModels/CourseRequestModel.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import 'CourseScreen.dart';
class CourseData extends StatefulWidget {
  const CourseData({Key? key}) : super(key: key);

  @override
  State<CourseData> createState() => _CourseDataState();
}

class _CourseDataState extends State<CourseData> {

  CourseBloc? courseBloc;

  @override
  void initState() {
    // TODO: implement initState
    courseBloc=BlocProvider.of<CourseBloc>(context);
    courseBloc!.add(ShowAllCourseWithDetailsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseScreen()));
        },
        child:const Icon(Icons.add),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.14),
          child:const AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
              child: Center(child: text("Here you got Courses list:-",FontWeight.normal,18.0,Colors.black38)),
            ),
            Divider(
              indent:20,
              endIndent: 20,
              thickness: 2,
              height: MediaQuery.of(context).size.height*0.1/10,
              color: Colors.orangeAccent,
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child:
              BlocBuilder<CourseBloc, CourseStates>(
                builder: (context, state) {
                  if (state is CourseLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  else if (state is CourseShowDataState) {
                    return ListView.builder(
                        itemCount: state.list!.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          /* var isAdded = courses.where(
                                              (data) => data == state.list![index].courseId);*/
                          return Card(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/7,right: MediaQuery.of(context).size.height*0.1/7),
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0),
                              ),
                              color: Colors.white,
                              elevation: 10,
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  //   dismissible: DismissiblePane(onDismissed: (){},),
                                  children: [

                                    SlidableAction(
                                      onPressed: (
                                          BuildContext context) async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CourseScreen(
                                                      requestModel: CourseRequestModel(
                                                          courseId: state
                                                              .list![index]
                                                              .courseId!,
                                                          status: state
                                                              .list![index]
                                                              .status,
                                                          courseName: state
                                                              .list![index]
                                                              .courseName,
                                                          courseCode: state
                                                              .list![index]
                                                              .courseCode),)));
                                      },
                                      backgroundColor: const Color(
                                          0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_rounded,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (
                                          BuildContext context) async {
                                        DeletePressed(
                                            state.list![index]
                                                .courseId);
                                      },
                                      backgroundColor: const Color(
                                          0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),

                                  ],
                                ),

                                child: Padding(
                                  padding:  EdgeInsets.only(
                                      top:MediaQuery.of(context).padding.top+2, bottom: MediaQuery.of(context).padding.bottom+2),
                                  child: ListTile(
                                    leading:const CircleAvatar(
                                        child: Icon(
                                            CupertinoIcons.heart)
                                    ),
                                    title: text(
                                        state.list![index].courseName
                                            .toString(),
                                        FontWeight.normal, 20.0,
                                        Colors.blue),
                                    subtitle: text("Description",
                                        FontWeight.normal, 12.0,
                                        Colors.blue),
                                    trailing:const Icon(Icons.format_align_justify),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(20.0)),
                                    onTap: () {
                                      OpenDialog(state.list![index]);
                                    },
                                  ),
                                ),
                              )
                          );
                        }

                    );
                  } else if (state is CourseErrorState) {
                    return const Center(
                        child: Text("Oops,Something went wrong"));
                  }
                  return Container();
                },

              ),
            )
          ],
        ),
      ),

    );
  }
  void DeletePressed(String? ID) {
    courseBloc!.add(
        RemoveCourseEvent(
            ID
        )
    );
  }

  Future OpenDialog(CourseRequestModel model) =>
      showDialog(context: context, builder: (context) =>
          AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),

              scrollable: true,
              content: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * (0.2/1.1 ),
                width: MediaQuery.of(context).size.width*0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Text("Course Detail",
                          style: TextStyle(color: Colors.black),),
                      ),
                      const Divider(
                        color: Colors.black26,
                      ),
                      Row(
                        children: [
                          /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                          Container(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                              child:const Text("Course Code:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                          Container(
                              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                              child: Text('${model.courseCode}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                            Container(
                                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                                child:const Text("Course Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                            Container(
                                margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                                child: Text('${model.courseName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                          ],
                        ),
                      ),
                      Row(
                        children: [
                          /*  Container(
                 margin: EdgeInsets.only(top:15),
                 child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                          Container(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                              child:const Text("Total CreditHours:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                          Container(
                              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                              child: Text('${model.totalCreditHours}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                      )


                    ],
                  ),
                ),
              )


          ));
}
