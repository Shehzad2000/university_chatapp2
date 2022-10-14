import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:university_chatapp2/Screens/Courses/CourseData.dart';
import 'package:university_chatapp2/Utility/Cards/TeacherDashBoardCard.dart';
import 'package:university_chatapp2/Utility/Cards/UserDashBoardCard.dart';

import '../../Utility/Cards/DashBoard_Cards.dart';
import '../../Utility/Cards/Dashboard_Cards2.dart';
import '../../Utility/Contraints/Dashboard_Constraints.dart';
import '../../Utility/Contraints/Gradient_contraints.dart';
import '../../Utility/Contraints/Text.dart';
import '../../Utility/Draw.dart';
import '../../Utility/Widget/AppBarWidget.dart';
import '../../Utility/Widget/IconButtons.dart';
import '../Student/DataTable/SlideableListView.dart';
import '../Teacher/DataTable/SlideableListView.dart';
import '../utils/constants.dart';
class TeacherDashBoard extends StatefulWidget {
  const TeacherDashBoard({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoard> createState() => _TeacherDashBoardState();
}

class _TeacherDashBoardState extends State<TeacherDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: MyHomePage(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget()),
      //drawer: DashBoard_Drawer,
      /*appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title:const Center(
            child: Text("University_ChatApp",
            style: display1,),
          ),
           // leading: MenuWidget(),
            actions: <Widget>[
        IconButton(
          onPressed: (){},
        icon:iconButton(Icons.refresh,null,null),
      ),], //IconButton
        backgroundColor: Colors.transparent,
          elevation: 0,

          flexibleSpace: ClipPath(
            clipper: MyCustomClipperForAppBar(),
            child: decAppContainer,
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                child: GestureDetector(
                  child: Column(
                    children: [
                      Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/4,left: MediaQuery.of(context).size.height*0.1/4),
                        height: MediaQuery.of(context).size.height*0.1/4,
                        child: Row(
                          children: [
                            text("Dashboard",FontWeight.bold,17.0,Colors.blueGrey)
                          ],

                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.1/6,
                      ),
                      Container(
                          margin:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/4,right:MediaQuery.of(context).size.height*0.1/5),
                          width: double.maxFinite,
                          decoration: decorationContainer,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:  EdgeInsets.only(
                                        top: MediaQuery.of(context).padding.top-13, left: MediaQuery.of(context).padding.left+18, right: MediaQuery.of(context).padding.right+28,),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  text("Registered", FontWeight.w200,20.0,Constants.background.withOpacity(0.7)),

                                                  text("Courses",FontWeight.w200,30.0,Constants.background),

                                                  text("1",FontWeight.bold,40.0,Colors.orangeAccent),

                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context).size.height*0.1,
                                              height: MediaQuery.of(context).size.height*0.1,
                                              child: FaIcon(FontAwesomeIcons.bookJournalWhills,color: Colors.orangeAccent,size: 50,))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: MediaQuery.of(context).size.height*.1/35,
                                    indent: 20,
                                    thickness: 1,
                                    endIndent: 20,
                                    // color: Constants.background,
                                    color: Colors.orangeAccent,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    padding:  EdgeInsets.only(left:MediaQuery.of(context).padding.left+20 , right: MediaQuery.of(context).padding.top),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                          },
                                          child: Container(
                                            padding:
                                            const EdgeInsets.symmetric(vertical: 10),
                                            child: Row(
                                                children: [
                                                  text("Courses",FontWeight.w200,17.0,Constants.background.withOpacity(1)),
                                                  /*Text(
        'Doubts',
        style: TextStyle(
        color: Constants.background
              .withOpacity(1),
        fontWeight: FontWeight.w200,
        fontSize: 17),
        ),*/
                                                  iconButton(Icons.arrow_forward_ios,Colors.orangeAccent,17),
                                                  /* const Icon(
        Icons.arrow_forward_ios,
        color: Colors.orangeAccent,
        size: 17,
        )*/
                                                ]),),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                          },
                                          child: Container(
                                            padding:
                                            EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.horizontal),
                                            child: Row(
                                              children: [
                                                text('Give an info',FontWeight.w200,17.0,Constants.background
                                                    .withOpacity(1)),
                                                /*Text(
        'Ask a doubt',
        style: TextStyle(
        color: Constants.background
              .withOpacity(1),
        fontWeight: FontWeight.w200,
        fontSize: 17),
        ),*/
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.1/10,
                                                ),
                                                const Icon(
                                                  Icons.question_answer,
                                                  color: Colors.orangeAccent,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.1/15,
                                  )
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CourseData()));
                  },
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                height: MediaQuery.of(context).size.height*.1/2,
                thickness: 3,
                // color: Constants.background,
                color: Colors.orangeAccent,
              ),



              Container(
                  alignment: Alignment.topLeft,
                  // color: Colors.red,
                  margin:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/5,bottom: 10),
                  child: text("What's on your mind today!",FontWeight.normal,15.0,Colors.blueGrey)
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.48/2,
                        child:TeacherDashboard_Card()
                    ),
                  ],
                ),
              ),



            ]),

      ),

    );



  }
}
