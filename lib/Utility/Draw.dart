
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpEvent.dart';
import 'package:university_chatapp2/Screens/Admin/AdminLogin.dart';
import 'package:university_chatapp2/Screens/Department/Department.dart';
import 'package:university_chatapp2/Screens/Profile/AdminProfile/AdminProfile.dart';
import 'package:university_chatapp2/Screens/Student/StudentDetail.dart';
import 'package:university_chatapp2/Screens/Teacher/DataTable/SlideableListView.dart';
import 'package:university_chatapp2/Screens/Teacher/TeacherDetail.dart';
import 'package:university_chatapp2/Utility/Widget/NavigationBar1.dart';

import '../Bloc/AdminBloc/SignUpState.dart';
import '../Bloc/AdminBloc/SignUpbloc.dart';
import '../Screens/Courses/CourseData.dart';
import '../Screens/Courses/CourseScreen.dart';
import '../Screens/Department/DepartmentList.dart';
import '../Screens/Semester/Semester.dart';
import '../Screens/Student/DataTable/SlideableListView.dart';
import 'Contraints/Text.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<FaIcon> listIcons=const [
  FaIcon(FontAwesomeIcons.home),
  FaIcon(FontAwesomeIcons.school),
  FaIcon(FontAwesomeIcons.book),
  FaIcon(FontAwesomeIcons.userGraduate),
  FaIcon(FontAwesomeIcons.chalkboardTeacher),
  FaIcon(FontAwesomeIcons.baby),
  FaIcon(FontAwesomeIcons.addressBook)
];
List<String> TextList=[
  "Home",
  "Department",
  "Courses",
  "Students",
  "Teachers",
  "setting",
  "logout"
];
List<dynamic> list=[
  navbar1(),
  DepartmentData(),
  const CourseData(),
  GetAllStudentData(),
  AllTeachersData(),
  Container(),
  const AdminLoginScreen(),
];

SignUpBloc? signUpBloc;

@override
  void initState() {
    // TODO: implement initState
  signUpBloc=BlocProvider.of<SignUpBloc>(context);
  signUpBloc!.add(GetSingleAdminEvent(ID:'33apIeiWzzIuZyc8Tedf'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
   child: SizedBox(
     width: MediaQuery.of(context).size.width-60,
     child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           buildHeader(context),
           buildMenuItems(context)
         ],
     ),
   ),

    );
  }

 Widget buildHeader(BuildContext context) =>Material(
   color: Colors.blue.shade700,
   child: InkWell(
     onTap: (){
       Navigator.pop(context);
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AdminProfile()));
     },
     child: Container(
       color: Colors.lightBlueAccent.shade700,
       padding: EdgeInsets.only(
         top: MediaQuery.of(context).padding.top+24,
         bottom: MediaQuery.of(context).padding.top-10
       ),
       child: BlocBuilder<SignUpBloc, SingUpStates>(
  builder: (context, state) {
    if(state is SignUpLoadingState){
      return const CircularProgressIndicator();
    }else if(state is SignUpSuccessState){
      return Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height*.1/1.4,
            backgroundColor: Colors.red,
            backgroundImage:const AssetImage('assets/images/z.jpg'),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height*0.1/4
          ),
          Container(
            child: text(state.adminRequestModel!.adminName.toString(),FontWeight.normal,18.0,Colors.white),
          ),
          Container(
            //    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom*0.5),
            child: text(state.adminRequestModel!.adminEmail.toString(),FontWeight.normal,14.0,Colors.white),
          )
        ],
      );
    }
  return Container();
  },
),
     ),
   ),
 );
  Widget buildMenuItems(BuildContext context)=>Container(
    color: Colors.white,
    padding:  EdgeInsets.only(left: MediaQuery.of(context).padding.left+15,
    bottom: MediaQuery.of(context).padding.bottom),
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context,index){
            return (index!=5)?ListTile(
              leading:  listIcons[index],
              title: Text(TextList[index]),
              onTap: (){
                Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>list[index]));
              },
            ):(
                (index==5)?(
                    Column(
                      children: [
                       Divider(
                      height: MediaQuery.of(context).size.height*0.1/8,
                      indent: 20,
                      thickness: 0.5,
                      endIndent: 20,
                      // color: Constants.background,
                      color: Colors.black,),
                    ListTile(
                    leading:  listIcons[index],
                    title: Text(TextList[index]),
                onTap: (){
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>list[index]));
            },)
                      ]
                )
                ):( ListTile(
                  leading:  listIcons[index],
                  title: Text(TextList[index]),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>list[index]));
                  },))
            );
          }),
        ),
      ],
    ),
  );


}