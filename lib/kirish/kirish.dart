import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/registratsiya/registration.dart';

class Kirish extends StatefulWidget {
  const Kirish({Key key}) : super(key: key);

  @override
  _KirishState createState() => _KirishState();
}

class _KirishState extends State<Kirish> {
  startTimer() async {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Registration())));
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text("my taxi"),
      ),
    );
  }
}
