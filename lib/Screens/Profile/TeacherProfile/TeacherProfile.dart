import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Event.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Models/RequestModels/StudentRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Repo/StudentRepo.dart';
import 'package:university_chatapp2/Repo/TeacherRepo.dart';
import 'package:university_chatapp2/Screens/Profile/TeacherProfile/teacherEditProfile.dart';

import '../../../Bloc/StudentBloc/student_bloc.dart';
import '../../../Bloc/TeacherBloc/Teacher_Bloc.dart';
import '../../../Utility/Contraints/Text.dart';
import '../../../Utility/Widget/AppBarWidget.dart';
import '../../../Utility/Widget/ListTile.dart';
import '../../../Utility/Widget/MyNav.dart';
import '../../../Utility/Widget/NavigationBar1.dart';
class TeacherProfile extends StatefulWidget {
  String? ID;
  TeacherProfile({Key? key,this.ID}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}
/*final List dummyList = List.generate(5, (index) {
  return {
    "id": index,
    "title": "This is the title $index",
    "subtitle": "This is the subtitle $index"
  };
});*/


class _TeacherProfileState extends State<TeacherProfile> {
  TeacherBloc? teacherBloc;

  @override
  void initState() {
    teacherBloc = BlocProvider.of<TeacherBloc>(context);
    teacherBloc!.add(GetTeacherDetailsEvent("7sHbGvZERReD2qbSCPKF"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*.13),
          child:const AppBarWidget()
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocBuilder<TeacherBloc,TeacherStates>(builder: (context,state){
              if(state is TeacherLoadingState) {
                return const CircularProgressIndicator();
              } else if(state is TeacherSuccessState)
              {
                return Stack(
                  children: [
                    Column(
                      children: [

                        Center(
                          child: Container(
                            margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/2),
                            height: MediaQuery.of(context).size.height*.16,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            decoration: const BoxDecoration(
                              // color: Colors.green,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/z.jpg"),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8),
                          child: text(state.teacherRequestModel!.teacherName.toString(), FontWeight.normal, 15.0, Colors.blue),
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/16,bottom: MediaQuery.of(context).size.height*0.1/16),
                          child: text(
                              state.teacherRequestModel!.teacherEmail.toString(), FontWeight.normal, 15.0,
                              Colors.blue
                          ),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height*.1/8,
                          thickness: 1,
                        ),
                        SizedBox(
                          // margin: const EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.height*.19/3,
                          child: ListTileWidget(title: "Name",subtitle: state.teacherRequestModel!.teacherName.toString()),
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                          height: MediaQuery.of(context).size.height*.19/3,
                          child: ListTileWidget(title: "Email",subtitle: state.teacherRequestModel!.teacherEmail.toString()),
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                          height: MediaQuery.of(context).size.height*.19/3,
                          child: ListTileWidget(title: "Password",subtitle: state.teacherRequestModel!.teacherPassword.toString()),
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                          height: MediaQuery.of(context).size.height*.19/3,
                          child: ListTileWidget(title: "Gender",subtitle: state.teacherRequestModel!.teacherGender.toString(),),
                        ),
                        Container(
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                          height: MediaQuery.of(context).size.height*.19/3,
                          child: ListTileWidget(title: "status",subtitle: state.teacherRequestModel!.teacherStatus==1?"Active":"InActive",),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height*.2/3,
                        ),


                      ],

                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TeacherEditProfile(
                            requestModel:TeacherRequestModel(
                                adminID:state.teacherRequestModel!.adminID,teacherName: state.teacherRequestModel!.teacherName,teacherEmail: state.teacherRequestModel!.teacherEmail,
                                teacherContact: state.teacherRequestModel!.teacherContact,teacherGender: state.teacherRequestModel!.teacherGender,teacherStatus: state.teacherRequestModel!.teacherStatus,
                                teacherPassword: state.teacherRequestModel!.teacherPassword,teacherImage: state.teacherRequestModel!.teacherImage

                            )

                        )));
                      },
                      child:Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15, left: MediaQuery.of(context).size.height*.26),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: MediaQuery.of(context).size.height*0.1/3.8,
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.height*0.1/4.2,
                            child:const Icon(CupertinoIcons.pencil, size: 30,),
                          ),
                        ),
                      ),
                    ),
                  ],

                );
              }
              return Container();
            }

            ),

          ],
        ),
      ),
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          iconTheme:const IconThemeData(color: Colors.white)), child: navbar2()),
    );
  }
}