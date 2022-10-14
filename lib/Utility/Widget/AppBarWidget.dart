import 'package:flutter/material.dart';

import '../Contraints/Dashboard_Constraints.dart';
import '../Custom_Clippers/AppBar_Clipper.dart';
import 'IconButtons.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(
        child: Text(
          "University_ChatApp",
          style: display1,
        ),
      ),

      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: iconButton(Icons.refresh, null, null),
        ),
      ], //IconButton
      backgroundColor: Colors.transparent,

      flexibleSpace: ClipPath(
        clipper: MyCustomClipperForAppBar(),
        child: decAppContainer,
      ),
    );
  }
}
