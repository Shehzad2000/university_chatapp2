import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpState.dart';
import 'package:university_chatapp2/Bloc/ChatBloc/chat_bloc.dart';
import 'package:university_chatapp2/Bloc/CoursesBloc/course_bloc.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';

import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_Bloc.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/Group_State.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Bloc.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_State.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_Bloc.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_State.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpbloc.dart';
import 'package:university_chatapp2/Bloc/StudentBloc/student_bloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Bloc.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Screens/Admin/AdminRegisteration.dart';
import 'package:university_chatapp2/Screens/Department/Department.dart';
import 'package:university_chatapp2/Screens/Department/DepartmentDetail.dart';

import 'package:university_chatapp2/Screens/Profile/StudentProfile/StudentProfile.dart';
import 'package:university_chatapp2/Screens/Semester/Semester.dart';
import 'package:university_chatapp2/Screens/Student/StudentDetail.dart';
import 'package:university_chatapp2/Screens/Teacher/TeacherRegisteration.dart';
import 'package:university_chatapp2/Utility/Widget/MyNav.dart';

import 'Bloc/BatchBloc/batch_bloc.dart';
import 'Bloc/DepartmentBloc/Department_State.dart';
import 'Bloc/GetUserIdBloc/getuser_id_bloc.dart';
import 'Bloc/GroupBloc/Group_Bloc.dart';
import 'Bloc/GroupBloc/Group_Event.dart';
import 'Bloc/RegisterBloc/register_bloc.dart';
import 'Bloc/RegisterCourseBloc/register_course_bloc.dart';
import 'Screens/Admin/AdminLogin.dart';
import 'Screens/Batch/BatchData.dart';
import 'Screens/Batch/BatchScreen.dart';
import 'Screens/ChatScreen/ChatScreen.dart';
import 'Screens/ChatScreen/MessageScreen.dart';
import 'Screens/ChatScreen/UserListTileScreen.dart';
import 'Screens/Courses/CourseData.dart';
import 'Screens/Courses/CourseScreen.dart';
import 'Screens/CustomSplashScreen/CustomSplashScreen.dart';
import 'Screens/Dashboard/Dashboard.dart';
import 'Screens/Dashboard/TeacherDashboard.dart';
import 'Screens/Dashboard/UserDashBoard.dart';
import 'Screens/Department/DepartmentList.dart';

import 'Screens/Profile/AdminProfile/AdminProfile.dart';
import 'Screens/Profile/AdminProfile/EditProfile.dart';
import 'Screens/Profile/TeacherProfile/TeacherProfile.dart';
import 'Screens/RegisterCourses/RegisterCourses.dart';
import 'Screens/RegisteredBatchStudent/BatchStudents.dart';
import 'Screens/RegisteredBatchStudent/RegisteredUsers.dart';
import 'Screens/Search/SearchGroups.dart';
import 'Screens/Search/SearchStudents.dart';
import 'Screens/Search/SearchTeachers.dart';
import 'Screens/Semester/DataTable/SlideableListView.dart';
import 'Screens/Student/DataTable/SlideableListView.dart';
import 'Screens/Student/StudentLogin.dart';
import 'Screens/Student/StudentRegisteration.dart';
import 'Screens/Teacher/DataTable/SlideableListView.dart';
import 'Screens/Teacher/TeacherDetail.dart';
import 'Screens/Teacher/TeacherLogin.dart';
import 'Utility/Cards/Dashboard_Cards2.dart';
import 'Utility/Draw.dart';
import 'Utility/Widget/AppBar/UserAppBarWidget.dart';
import 'Utility/Widget/NavigationBar1.dart';
import 'Utility/Widget/NavigationBar2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (BuildContext context) => SignUpBloc(SignUpInitialState()),
          ),
          BlocProvider<DepartmentBloc>(
            create: (BuildContext context) =>
                DepartmentBloc(DepartmentInitialState()),
          ),
          BlocProvider<SemesterBloc>(
            create: (BuildContext context) =>
                SemesterBloc(SemesterInitialState()),
          ),
          BlocProvider<GetuserIdBloc>(
            create: (context) => GetuserIdBloc(),
          ),
          BlocProvider<TeacherBloc>(
              create: (BuildContext context) =>
                  TeacherBloc(TeacherInitialState())),
          BlocProvider<SemesterBloc>(
              create: (BuildContext context) =>
                  SemesterBloc(SemesterInitialState())),
          BlocProvider<PositionBloc>(
              create: (BuildContext context) =>
                  PositionBloc(PositionInitialState())),
          BlocProvider<StudentBloc>(
              create: (BuildContext context) =>
                  StudentBloc(StudentInitialState())),
          BlocProvider<BatchBloc>(
              create: (BuildContext context) => BatchBloc(BatchInitialState())),
          BlocProvider<CreateGroupBloc>(
              create: (BuildContext context) =>
                  CreateGroupBloc(CreateGroupInitialState())),
          BlocProvider<RegisterGroupBloc>(
              create: (BuildContext context) =>
                  RegisterGroupBloc(RegisterInitialState())),
          BlocProvider<ChatBloc>(
              create: (BuildContext context) => ChatBloc(ChatInitialState())),
          BlocProvider<GroupBloc>(
              create: (BuildContext context) => GroupBloc(GroupInitialState())),
          BlocProvider<CourseBloc>(
              create: (BuildContext context) => CourseBloc(CourseInitialState())),
          BlocProvider<RegisterCourseBloc>(
              create: (BuildContext context) => RegisterCourseBloc(RegisterCourseInitialState())),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            // initialRoute: '/',
            // routes: {
            //   MyRoutes.homeScreen: (context) => HomeScreen(),
            //   MyRoutes.loginScreen: (context) => LoginScreen(),
            //   MyRoutes.signUp: (context) => SignUp(),
            //   MyRoutes.forgotPassword: (context) => ForgotPassword(),
            // },
            home: ChatScreen()
    ));
  }
}
