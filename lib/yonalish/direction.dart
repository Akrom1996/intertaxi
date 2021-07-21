import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intertaxi/asosiy/asosiy.dart';
import 'package:intertaxi/constants/buttonNext.dart';
import 'package:intertaxi/constants/regionData.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/yonalish/components/dialog.dart';
import 'package:intertaxi/yonalish/components/fields.dart';
import 'package:provider/provider.dart';

class Direction extends StatefulWidget {
  const Direction({Key key}) : super(key: key);

  @override
  _DirectionState createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  TextEditingController textEditingController1;
  TextEditingController textEditingController2;
  TextEditingController textEditingController11;
  TextEditingController textEditingController22;
  String selectedRegion_A = "";
  String selectedRegion_B = "";
  int index_A;
  int index_B;
  List<bool> selected_A = List<bool>.generate(22, (index) => false);
  List<bool> selected_B = List<bool>.generate(22, (index) => false);
  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController11 = TextEditingController();
    textEditingController22 = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDistricts(context, textEditingController11, 1);
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDistricts(context, textEditingController22, 2);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserRegistration>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Qatnov marshruti",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.06 * width),
        child: Column(
          children: [
            // info text
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.1 * width,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(top: 0.05 * width)),
                  Text(
                    "O'z marshrutingizni kiritish orqali ushbu yo'nalishdagi buyurtmalarni kuzatib turishingiz mumkin.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                  ),
                ],
              ),
            ),
            // Qatnov yo'nalishi
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Birinchi nuqtani tanlang",
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  textAlign: TextAlign.start,
                ),
                directionContainer(
                    selected: selectedRegion_A,
                    city_index: index_A,
                    controller1: textEditingController1,
                    controller2: textEditingController11,
                    hint1: "Birinchi viloyat",
                    hint2: "Tuman(lar)ni tanlang",
                    onTappedContainer1: () {
                      showRegions(context, textEditingController1, 1);
                      textEditingController11.text = "";
                    },
                    onTappedContainer2: () async {
                      // setState(() {
                      final result = await showDistricts(
                          context, textEditingController11, 1);
                      // });
                      print("text1 ${textEditingController11.text}, $result");
                    }),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 0.1 * width)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ikkinchi nuqtani tanlang",
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                ),
                directionContainer(
                  selected: selectedRegion_B,
                  city_index: index_B,
                  controller1: textEditingController2,
                  controller2: textEditingController22,
                  hint1: "Ikkinchi viloyat",
                  hint2: "Tuman(lar)ni tanlang",
                  onTappedContainer1: () {
                    showRegions(context, textEditingController2, 2);
                    textEditingController22.text = "";
                  },
                  onTappedContainer2: () async {
                    // setState(() {
                    final result = await showDistricts(
                        context, textEditingController22, 2);
                    // });
                    print("text2 ${textEditingController22.text}, $result");
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 0.05 * width),
                    child: mainNextButton(
                      onNext: () {
                        if (textEditingController11.text == "" ||
                            textEditingController22.text == "") {
                          return showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  content: Text(
                                    "Iltimos yo'nalishlarni to'ldiring",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              });
                        } else {
                          user.setUserDirection(textEditingController1.text,
                              textEditingController2.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MainPage(),
                            ),
                          );
                        }
                      },
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }

  Future<dynamic> showDistricts(
      BuildContext context, TextEditingController controller, int region) {
    var currentValue = region == 1 ? selected_A : selected_B;
    // currentValue.fillRange(0, currentValue.length, false);
    print("show current $currentValue");
    print("show selected $selected_A");
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: MyDialog(
              region: region,
              currentValue: currentValue,
              index_A: index_A,
              index_B: index_B,
              selectedRegion_A: selectedRegion_A,
              selectedRegion_B: selectedRegion_B,
              selected_A: selected_A,
              selected_B: selected_B,
              controller: controller,
            ),
          );
        });
  }

  Future<dynamic> showRegions(
      BuildContext context, TextEditingController controller, int region) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              "Viloyatingiz",
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          controller.text = regions[index];
                          region == 1
                              ? selectedRegion_A = regions[index]
                              : selectedRegion_B = regions[index];
                          region == 1 ? index_A = index : index_B = index;
                        });
                        print(selectedRegion_A);
                        print(selectedRegion_B);
                        print(index_A);
                        print(index_B);

                        Navigator.pop(context);
                      },
                      // onTapped,
                      child: ListTile(
                        title: Text(
                          "${regions[index]}",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: regions.length),
            ),
          );
        });
  }
}
