import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university_chatapp2/Screens/ChatScreen/UserListTileScreen.dart';
import 'package:university_chatapp2/Utility/Widget/ListTile.dart';

import '../../Utility/Widget/AppBar/UserAppBarWidget.dart';
import '../../Utility/Widget/AppBar/UserListTile.dart';
import '../../Utility/Widget/IconButtons.dart';
import '../../Utility/Widget/NavigationBar2.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
         leadingWidth: 17,
         iconTheme: IconThemeData(
             color: Colors.white
         ),
         leading: GestureDetector(
           onTap: (){},
           child: iconButton(CupertinoIcons.arrow_left_circle_fill, Colors.white, 23),
           /*child:IconButtonWidget(iconData: CupertinoIcons.arrow_left_circle_fill,color: Colors.white,)*/ ),
         title: Center(child: Text("Groups")),
         actions: [
           Padding(
               padding: EdgeInsets.only(right: 20.0),
               child: GestureDetector(
                 onTap: () {},
                 child: Icon(
                     Icons.more_vert
                 ),
               )
           ),
         ],
       ),

     body:ListView(
       children: [
         Container(
           child: UserListTile(),
         )
       ],
     )


   );

  }

}

