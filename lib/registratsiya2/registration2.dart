import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intertaxi/avtorasm/avtorasm.dart';
import 'package:intertaxi/constants/buttonNext.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/otp/otp.dart';
import 'package:intertaxi/registratsiya2/components/inputField.dart';
import 'package:provider/provider.dart';

class Registration2 extends StatefulWidget {
  final int type;
  const Registration2({Key key, @required this.type}) : super(key: key);

  @override
  _Registration2State createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
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

  @override
  void initState() {
    super.initState();
    type = widget.type;
    getPosition();
  }

  Future getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    final coordinates = //Coordinates(40.731419,
        // 72.331131);
        Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      locationAddr = addresses[0].addressLine;
    });
    // print();
  }

  // Future uploadImage(File image) async {
  //   String fileName = image.path.split('/').last;
  //   dio.FormData formData = dio.FormData.fromMap({
  //     "upload":
  //         await dio.MultipartFile.fromFile(image.path, filename: fileName),
  //     "userName": userName,
  //   });
  //   var response = await dio.Dio().post(
  //       "http://localhost:4000/user/upload-profile-image/$email",
  //       data: formData);
  //   if (response.statusCode == 200)
  //     return response.data['file_name'];
  //   else
  //     Future.error(response.data['error']);
  // }

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

  onNextPressed() async {
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
      // Save to database
      await saveToDB();
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => OtpForm(type: type)));
    }
  }

  Future saveToDB() async {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Ro'yxatdan o'ting",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
      ),
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
                hintText: "Ism(Familiya)ingizni kiriting",
                controllerText: controller1,
                callback: (newTxt) => {name = newTxt, print(newTxt)},
              ),
              // inputField(
              //   validate: (txt) {
              //     if (txt.length == 0) {
              //       return "Familiyangizni kiriting";
              //     } else
              //       return null;
              //   },
              //   prefixIcon: null,
              //   isName: true,
              //   width: width,
              //   hintText: "Familiyangizni kiriting",
              //   controllerText: controller2,
              //   callback: (newTxt) => {familyName = newTxt, print(newTxt)},
              // ),

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
                hintText: "Tel. raqamni kiriting",
                controllerText: controller3,
                callback: (newTxt) => {phoneNumber = newTxt, print(newTxt)},
              ),
              type == 1
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
                      hintText: "Avto raqamingiz",
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
                hintText: "Mo'ljalni kiriting",
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
                margin: EdgeInsets.only(right: 0.1 * width, top: 0.08 * width),
                child: mainNextButton(
                  onNext: onNextPressed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
