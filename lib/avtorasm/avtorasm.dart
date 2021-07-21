import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intertaxi/constants/buttonNext.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/yonalish/direction.dart';
import 'package:provider/provider.dart';
// import 'package:numberpicker/numberpicker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Avtorasm extends StatefulWidget {
  const Avtorasm({Key key}) : super(key: key);

  @override
  _AvtorasmState createState() => _AvtorasmState();
}

class _AvtorasmState extends State<Avtorasm> {
  List<Asset> images = [];

  Future<void> _imgFromGallery() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: false,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "Rasmlar",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
    });
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
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var userData = Provider.of<UserRegistration>(context);
    print(userData.getUserInfo());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: Text(
          "Avtomobil rasmlari",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // text
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 0.1 * width, horizontal: 0.06 * width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(top: 0.05 * width)),
                  Text(
                    "Istasangiz avtomobil rasmlarini yuklang yoki o'tkazib yuboring. Bu orqali mijozlar sizda qanday qulayliklar mavjudligini ko'rsatishingiz mumkin.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                  ),
                ],
              ),
            ),
            // image loading button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.06 * width),
              width: double.infinity,
              // height: 0.06 * width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 0.02 * width),
                  primary: Colors.grey[200],
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  loadImage(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/camera.svg",
                      width: 0.1 * width,
                    ),
                    Padding(padding: EdgeInsets.only(left: 0.04 * width)),
                    Text(
                      "(${images.length}) / 8",
                      style: TextStyle(color: Colors.grey[800], fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
            // (() {
            //   if (images.length != 0)
            //     for (int i = 0; i < images.length; i++) {
            //       Asset asset = images[i];
            //       return Container(
            //           margin: EdgeInsets.symmetric(
            //               horizontal: 0.06 * width, vertical: 0.1 * width),
            //           width: double.infinity,
            //           // height: 0.8 * width,
            //           child: Card(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(20.0),
            //             ),
            //             child: AssetThumb(
            //               asset: asset,
            //               width: 300,
            //               height: 300,
            //             ),
            //           ));
            //     }
            //   else
            //     return SizedBox.shrink();
            // }()),

            // images
            images.length != 0
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 0.06 * width, vertical: 0.03 * width),
                    width: double.infinity,
                    height: 0.8 * width,
                    child: GridView.count(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      children: List.generate(images.length, (index) {
                        Asset asset = images[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: AssetThumb(
                            quality: 100,
                            asset: asset,
                            width: 100,
                            height: 100,
                          ),
                        );
                      }),
                    ),
                  )
                : SizedBox.shrink(),

            // next
            Container(
              margin: EdgeInsets.only(
                  right: 0.06 * width,
                  left: 0.06 * width,
                  bottom: 0.1 * width,
                  top: 0.05 * width),
              child: mainNextButton(
                onNext: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Direction()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
