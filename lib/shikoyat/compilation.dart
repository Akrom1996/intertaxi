import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/shikoyat/components/textformStyle.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Compilation extends StatefulWidget {
  const Compilation({Key key}) : super(key: key);

  @override
  _CompilationState createState() => _CompilationState();
}

class _CompilationState extends State<Compilation> {
  FocusNode focusNode = FocusNode();
  List<Asset> images = [];

  Future<void> _imgFromGallery() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
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

  Future onNextPressed() {
    Navigator.pop(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => MainPage(),
    //   ),
    // );
  }

  void panDown() {
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double spacingSize = 0.05 * width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Taklif va shikoyatlar",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: GestureDetector(
        onTap: panDown,
        onVerticalDragStart: (s) {
          panDown();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: spacingSize, vertical: spacingSize),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Taklif yoki shikoyatlaringizni kiriting",
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: spacingSize, vertical: spacingSize),
                width: double.infinity,
                // height: width,
                child: TextFormField(
                  maxLength: 3000,
                  focusNode: focusNode,
                  cursorColor: primaryColor,
                  maxLines: 12,
                  decoration: decoration("Xabarni kiriting"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: spacingSize, vertical: spacingSize),
                width: double.infinity,
                height: 0.15 * width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.14 * width,
                      height: 0.14 * width,
                      child: ElevatedButton(
                        onPressed: () {
                          focusNode.unfocus();
                          loadImage(context);
                        },
                        child: SvgPicture.asset(
                          "./assets/svg/camera.svg",
                          height: spacingSize,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          primary: Colors.grey[300],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 7)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: AssetThumb(
                                asset: images[index],
                                width: 90,
                                height: 90,
                              ),
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    vertical: spacingSize, horizontal: spacingSize),
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
                    "Yuborish",
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
