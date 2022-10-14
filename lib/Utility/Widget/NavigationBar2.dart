import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../../Screens/ChatScreen/ChatScreen.dart';
class NavigationBar2 extends StatefulWidget {
  const NavigationBar2({Key? key}) : super(key: key);

  @override
  State<NavigationBar2> createState() => _NavigationBar2State();
}

class _NavigationBar2State extends State<NavigationBar2> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() => currentIndex = index);
          },
          children: <Widget>[
            Container(
              child: ChatScreen(),
            ),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() => currentIndex = index);
          pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('Item Two'),
              icon: Icon(Icons.apps)
          ),
          BottomNavyBarItem(
              title: Text('Item Three'),
              icon: Icon(Icons.chat_bubble)
          ),
          BottomNavyBarItem(
              title: Text('Item Four'),
              icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }
}
