import 'package:flutter/material.dart';
import 'package:intertaxi/asosiy2/asosiy2.dart';
import 'package:intertaxi/avtorasm/avtorasm.dart';
import 'package:intertaxi/constants/buttonNext.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/otp/components/decoration.dart';
import 'package:intertaxi/yonalish/direction.dart';

class OtpForm extends StatefulWidget {
  final type;
  const OtpForm({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin1FocusNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();

  String key = "1234";
  String inputKey = "";
  int type;

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin1FocusNode.requestFocus();
    type = widget.type;
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      inputKey += value;
      focusNode.requestFocus();
    } else {}
  }

  onLastField() {
    {
      print(key);
      print(inputKey);
      if (key == inputKey) {
        if (type == 1)
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Avtorasm()));
        else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MainConsumer()));
        }
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Yuborilgan bir martalik parol xato kiritildi"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          inputKey = "";
                          Navigator.pop(context);
                          textEditingController1.clear();
                          textEditingController2.clear();
                          textEditingController3.clear();
                          textEditingController4.clear();
                          pin1FocusNode.requestFocus();
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w700),
                        )),
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              right: 0.1 * width, left: 0.1 * width, top: 0.5 * width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sms tarzida kelgan mahfiy parolni kiriting",
                  style: TextStyle(color: Colors.grey[800], fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.15 * width,
                    child: TextFormField(
                      // autofocus: true,
                      controller: textEditingController1,
                      focusNode: pin1FocusNode,
                      obscureText: true,
                      cursorColor: primaryColor,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 0.15 * width,
                    child: TextFormField(
                      focusNode: pin2FocusNode,
                      controller: textEditingController2,
                      obscureText: true,
                      cursorColor: primaryColor,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(value, pin3FocusNode),
                    ),
                  ),
                  SizedBox(
                    width: 0.15 * width,
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      controller: textEditingController3,
                      obscureText: true,
                      cursorColor: primaryColor,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(value, pin4FocusNode),
                    ),
                  ),
                  SizedBox(
                    width: 0.15 * width,
                    child: TextFormField(
                      focusNode: pin4FocusNode,
                      controller: textEditingController4,
                      obscureText: true,
                      cursorColor: primaryColor,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        if (value.length == 1) {
                          inputKey += value;
                          pin4FocusNode.unfocus();
                          onLastField();
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ),
                ],
              ),
              // SizedBox(height: SizeConfig.screenHeight * 0.15),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
