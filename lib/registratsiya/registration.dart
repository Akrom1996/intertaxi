import 'package:flutter/material.dart';
import 'package:intertaxi/constants/buttonNext.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/registratsiya/components/regBtn.dart';
import 'package:intertaxi/registratsiya2/registration2.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  int selected = 0;

  changeColor(int selectedBtn) {
    setState(() {
      selected = selectedBtn;
    });
  }

  nextPressed() {
    if (selected == 0) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text(
                "Iltimos tanlang",
                style: TextStyle(fontSize: 18),
              ),
            );
          });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Registration2(
                    type: selected,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "INTER TAXI",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          regButton(
            onPressedBtn: () => {
              changeColor(1)
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => TaxiRegistration()))
            },
            textBtn: "Taksi haydovchisi",
            iconBtn: Icons.local_taxi,
            color: selected == 1
                ? // Color(0xff20A4F3)
                // Colors.lightBlue
                primaryColor
                : Colors.white,
          ),
          regButton(
            onPressedBtn: () => {
              changeColor(2)

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => UserRegistration()))
            },
            textBtn: "Foydalanuvchi",
            iconBtn: Icons.person,
            color: selected == 2
                ? //Color(0xff20A4F3)
                // Colors.lightBlue
                primaryColor
                : Colors.white,
          ),
          Container(
            height: 0.1 * width,
          ),
          // regButton(
          //   onPressedBtn: nextPressed,
          //   textBtn: "Keyingi",
          //   iconBtn: null,
          //   color: //Colors.lightBlue
          //       primaryColor,
          // )
          Container(
            margin: EdgeInsets.only(right: 0.1 * width, top: 0.08 * width),
            child: mainNextButton(
              onNext: nextPressed,
            ),
          ),
        ],
      ),
    );
  }
}
