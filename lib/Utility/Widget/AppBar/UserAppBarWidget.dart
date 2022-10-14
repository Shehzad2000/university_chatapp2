import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university_chatapp2/Utility/Widget/AppBar/UserListTile.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';
import 'package:university_chatapp2/Utility/Widget/ListTile.dart';

import '../../../Screens/ChatScreen/ChatScreen.dart';
class UserAppBar extends StatefulWidget {
  const UserAppBar({Key? key}) : super(key: key);

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 17,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      leading: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>
                  ChatScreen()));

        },
        child: iconButton(CupertinoIcons.arrow_left_circle_fill, Colors.white, 23,),
        /*child:IconButtonWidget(iconData: CupertinoIcons.arrow_left_circle_fill,color: Colors.white,)*/ ),
      title: ListTileWidget1(title: "Name",subtitle: "Online"),
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
    );
  }
}
