import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpEvent.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpbloc.dart';
import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';
import 'package:university_chatapp2/Repo/AdminRepo.dart';
import 'package:university_chatapp2/Utility/Widget/AppBarWidget.dart';
import 'package:university_chatapp2/Utility/Widget/ListTile.dart';


import '../../../Bloc/AdminBloc/SignUpState.dart';
import '../../../Utility/Contraints/Text.dart';
import '../../../Utility/Widget/IconButtons.dart';
import '../../../Utility/Widget/MyNav.dart';
import '../../../Utility/Widget/NavigationBar1.dart';
import 'EditProfile.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}
/*final List dummyList = List.generate(5, (index) {
  return {
    "id": index,
    "title": "This is the title $index",
    "subtitle": "This is the subtitle $index"
  };
});*/
// void getData() async {
//   AdminFireBase obj = AdminFireBase();
//   AdminRequestModel model = await obj.getSingleUser();
// }

class _AdminProfileState extends State<AdminProfile> {
  SignUpBloc? signUpBloc;

  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    signUpBloc!.add(GetSingleAdminEvent());
   // getData();
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
        child: BlocBuilder<SignUpBloc,SingUpStates>(builder: (context,state){
          if(state is SignUpLoadingState) {
            return const CircularProgressIndicator();
          }
          else if(state is SignUpSuccessState)
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
                        child: text(state.adminRequestModel!.adminName.toString(), FontWeight.normal, 15.0, Colors.blue),
                      ),
                      Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/16,bottom: MediaQuery.of(context).size.height*0.1/16),
                        child: text(
                            state.adminRequestModel!.adminEmail!, FontWeight.normal, 15.0,
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
                        child: ListTileWidget(title: "Name",subtitle: state.adminRequestModel!.adminName),
                      ),
                      Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                        height: MediaQuery.of(context).size.height*.19/3,
                        child: ListTileWidget(title: "Email",subtitle: state.adminRequestModel!.adminEmail),
                      ),
                      Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                        height: MediaQuery.of(context).size.height*.19/3,
                        child: ListTileWidget(title: "Password",subtitle: state.adminRequestModel!.adminPassword),
                      ),
                      Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                        height: MediaQuery.of(context).size.height*.19/3,
                        child: ListTileWidget(title: "Gender",subtitle: state.adminRequestModel!.adminGender,),
                      ),
                      Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                        height: MediaQuery.of(context).size.height*.19/3,
                        child: ListTileWidget(title: "status",subtitle: state.adminRequestModel!.adminStatus==1?"Active":"InActive",),
                      ),
                       Divider(
                        height: MediaQuery.of(context).size.height*.2/3,
                      ),


                    ],

                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile(
                          requestModel:AdminRequestModel(
                              adminID:state.adminRequestModel!.adminID,adminName: state.adminRequestModel!.adminName,adminEmail: state.adminRequestModel!.adminEmail,
                              adminContact: state.adminRequestModel!.adminContact,adminGender: state.adminRequestModel!.adminGender,adminStatus: state.adminRequestModel!.adminStatus,
                              adminPassword: state.adminRequestModel!.adminPassword,adminImage: state.adminRequestModel!.adminImage

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

    );
  }
}
