import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Screens/Admin/AdminLogin.dart';
import 'package:university_chatapp2/Utility/Widget/NavigationBar1.dart';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../Bloc/GetUserIdBloc/getuser_id_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  String? id;
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetuserIdBloc>(context).add(GetUserId());
    Future.delayed(Duration(seconds: 3), () {
      var state = BlocProvider.of<GetuserIdBloc>(context).state;
      if (state is GetuserIdSuccess) {
        id = state.userId;
      }
    });
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    if (id != "") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navbar1()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminLoginScreen()));
    }
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/B1.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              'University ChatApp',
              style: TextStyle(fontSize: 30.0, color: Colors.orangeAccent),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            SizedBox(
              height: 20,
            ),
            SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: 100,
              appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                )),
                customColors: CustomSliderColors(
                    dotColor: Colors.white,
                    progressBarColor: Colors.black,
                    shadowColor: Colors.white,
                    trackColor: Colors.white),
                spinnerDuration: 4,
                animDurationMultiplier: 3,
                animationEnabled: true,
                startAngle: 0.0,
                angleRange: 360,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Initializing app...',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
