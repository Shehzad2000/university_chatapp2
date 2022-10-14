import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/StudentRequestModel.dart';
import 'package:university_chatapp2/Repo/StudentRepo.dart';
import 'package:university_chatapp2/Screens/Profile/StudentProfile/StudentEditprofile.dart';

import '../../../Bloc/StudentBloc/student_bloc.dart';
import '../../../Utility/Contraints/Text.dart';
import '../../../Utility/Widget/AppBarWidget.dart';
import '../../../Utility/Widget/ListTile.dart';
import '../../../Utility/Widget/MyNav.dart';
import '../../../Utility/Widget/NavigationBar1.dart';
class StudentProfile extends StatefulWidget {
  String? ID;
   StudentProfile({Key? key,this.ID}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  StudentBloc? studentBloc;

  @override
  void initState() {
    studentBloc = BlocProvider.of<StudentBloc>(context);
    studentBloc!.add(GetStudentRecordEvent("nrjnwmXdyLQwVIEMe7kz"));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget()
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<StudentBloc,StudentStates>(builder: (context,state){
          if(state is StudentLoadingState) {
            return const CircularProgressIndicator();
          }
          else if(state is StudentSuccessState)
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
                      child: text(state.requestModel!.studentName.toString(), FontWeight.normal, 15.0, Colors.blue),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/16,bottom: MediaQuery.of(context).size.height*0.1/16),
                      child: text(
                          state.requestModel!.studentEmail.toString(), FontWeight.normal, 15.0,
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
                      child: ListTileWidget(title: "Name",subtitle: state.requestModel!.studentName.toString()),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ListTileWidget(title: "Email",subtitle: state.requestModel!.studentEmail.toString()),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ListTileWidget(title: "Password",subtitle: state.requestModel!.studentPassword.toString()),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ListTileWidget(title: "Gender",subtitle: state.requestModel!.studentGender.toString(),),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ListTileWidget(title: "status",subtitle: state.requestModel!.studentStatus==1?"Active":"InActive",),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height*.2/3,
                    ),


                  ],

                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentEditProfile(
                        requestModel:StudentRequestModel(
                            adminID:state.requestModel!.adminID,studentName: state.requestModel!.studentName,studentEmail: state.requestModel!.studentEmail,
                            studentContact: state.requestModel!.studentContact,studentGender: state.requestModel!.studentGender,studentStatus: state.requestModel!.studentStatus,
                            studentPassword: state.requestModel!.studentPassword,studentImage: state.requestModel!.studentImage

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
        },

        ),
      ),
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          iconTheme:const IconThemeData(color: Colors.white)), child: navbar2()),
    );
  }
}