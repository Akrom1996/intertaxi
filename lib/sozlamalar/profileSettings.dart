import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intertaxi/constants/buttonNext.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/registratsiya2/components/inputField.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  var controller4 = TextEditingController();
  var controller5 = TextEditingController();

  String name = "";
  String familyName = "";
  String phoneNumber = "";
  String carNumber = "";
  String address = "";
  String locationAddr = "";
  int type;
  var _image;
  Map<String, dynamic> obj;
  final _formKey = GlobalKey<FormState>();

  _imgFromCamera() async {
    try {
      var image = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 50);

      setState(() {
        _image = File(image.path);
      });
    } catch (error) {
      throw new Error();
    }
  }

  _imgFromGallery() async {
    try {
      var image = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = File(image.path);
      });
    } catch (error) {
      Future.error(error);
    }
  }

  void loadImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: primaryColor,
                      ),
                      title: new Text('Galareyadan yuklash'),
                      onTap: () async {
                        await _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: primaryColor,
                    ),
                    title: new Text('Kameradan yuklash'),
                    onTap: () async {
                      await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  onNextPressed() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      // TODO submit

      if (type == 1) {
        obj = {
          "type": type,
          "userName": name,
          // "familyName": familyName,
          "phoneNumber": phoneNumber,
          "autoNumber": carNumber,
          "address": address
        };
      } else {
        obj = {
          "type": type,
          "userName": name,
          // "familyName": familyName,
          "phoneNumber": phoneNumber,
          "autoNumber": null,
          "address": address
        };
      }
      // context.
      Provider.of<UserRegistration>(context, listen: false).setUserInfo(obj);
      Navigator.pop(context);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => OtpForm(type: type)));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserRegistration>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profil sozlamalari",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0.1 * width, bottom: 0.1 * width),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey[400],
                      backgroundImage: (() {
                        print(_image);
                        if (_image == null) {
                          return Image.asset("assets/png/profile1.png").image;
                        } else {
                          return Image.file(_image).image;
                        }
                      }()),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () => loadImage(context),
                        child: CircleAvatar(
                          radius: 0.035 * width,
                          backgroundColor: Colors.grey[100],
                          child: SizedBox(
                            width: 0.045 * width,
                            child: SvgPicture.asset("assets/svg/camera.svg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // name input
              inputField(
                validate: (txt) {
                  if (txt.length == 0) {
                    return "Ismingizni kiriting";
                  } else
                    return null;
                },
                isNumber: false,
                prefixIcon: null,
                isName: true,
                width: width,
                hintText: "${user.userName}",
                controllerText: controller1,
                callback: (newTxt) => {name = newTxt, print(newTxt)},
              ),

              // phone input
              inputField(
                validate: (txt) {
                  if (txt.length == 0) {
                    return "Maydonni to'ldiring";
                  } else
                    return null;
                },
                isNumber: true,
                prefixIcon: Icon(
                  Icons.phone,
                  color: primaryColor,
                ),
                isName: false,
                width: width,
                hintText: "${user.phoneNumber}",
                controllerText: controller3,
                callback: (newTxt) => {phoneNumber = newTxt, print(newTxt)},
              ),
              user.type == 1
                  ? inputField(
                      validate: (txt) {
                        if (txt.length == 0) {
                          return "Maydonni to'ldiring";
                        } else
                          return null;
                      },
                      isNumber: false,
                      prefixIcon: null,
                      isName: false,
                      width: width,
                      hintText: "${user.autoNumber}",
                      controllerText: controller4,
                      callback: (newTxt) => {carNumber = newTxt, print(newTxt)},
                    )
                  : SizedBox.shrink(),
              inputField(
                validate: (txt) {
                  if (txt.length == 0) {
                    return "Maydonni to'ldiring";
                  } else
                    return null;
                },
                isNumber: false,
                prefixIcon: Icon(
                  Icons.home_sharp,
                  color: primaryColor,
                ),
                isName: false,
                width: width,
                hintText: "${user.address}",
                controllerText: controller5,
                callback: (newTxt) => {address = newTxt, print(newTxt)},
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0.1 * width,
                ),
                child: Text(
                  "$locationAddr",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    right: 0.1 * width, left: 0.1 * width, top: 0.08 * width),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: onNextPressed,
                  child: Text(
                    "O'zgartirish",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
