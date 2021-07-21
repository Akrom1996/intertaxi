import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intertaxi/asosiy/components/cardView.dart';
import 'package:intertaxi/asosiy/components/textSelection.dart';
import 'package:intertaxi/asosiy2/components/greyField.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/manzilSozlamalar/addressSettings.dart';
import 'package:intertaxi/registratsiya/registration.dart';
import 'package:intertaxi/shikoyat/compilation.dart';
import 'package:intertaxi/sozlamalar/profileSettings.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  bool listenValue = true;
  String address1;
  String address2;
  var user;
  List items = List.generate(10, (index) => index);
  Future addItem() {
    setState(() {
      items.insert(0, items.length + 1);
    });
  }

  //delete user
  Future<void> onExitApp() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRegistration>(context);

    double width = MediaQuery.of(context).size.width;
    double spacingSize = 0.05 * width;

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: newMethod(width, spacingSize),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  decoration: decorationContainer(Colors.white),
                  width: 0.32 * width,
                  child: Text(
                    "${user.address1}",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      user.setUserDirection(user.address2, user.address1);
                    },
                    icon: Icon(Icons.swap_horiz_rounded),
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  decoration: decorationContainer(Colors.white),
                  width: 0.32 * width,
                  child: Text(
                    "${user.address2}",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        child: listenValue
            ? RefreshIndicator(
                onRefresh: () async {
                  await addItem();
                },
                child: AnimatedList(
                    key: listKey,
                    // reverse: true,
                    initialItemCount: items.length,
                    itemBuilder: (context, index, animation) {
                      return cardView(width, index, spacingSize);
                    }),
              )
            : Center(
                child: Text(
                  "Sizda e'lonlar mavjud emas. Kuzatib borishni yoqib qo'ying iltimos.😞",
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }

  Drawer newMethod(double width, double spacingSize) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            height: 0.27 * width,
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                // horizontal: spacingSize,
                vertical: spacingSize),
            child: CircleAvatar(
              radius: 0.13 * width,
              backgroundImage: Image.asset("./assets/png/profile1.png").image,
            ),
          ),
          Text(
            "${user.userName}",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          Text(
            "${user.phoneNumber}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500]),
          ),
          greyField(
            spacingSize: spacingSize,
            width: width,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: spacingSize),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "E'lonlarni kuzatib borish",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Spacer(),
                CupertinoSwitch(
                    value: listenValue,
                    onChanged: (value) {
                      setState(() {
                        listenValue = value;
                      });
                    })
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: spacingSize),
            padding: EdgeInsets.only(right: 8, left: 8),
            // decoration: decorationContainer(Colors.grey[400]),
            child: Row(
              children: [
                Text(
                  "${user.address1}",
                  textAlign: TextAlign.center,
                  style: addrStyle(),
                ),
                Text(
                  " dan ",
                  style: TextStyle(
                      color: Colors.red[700], fontWeight: FontWeight.w500),
                ),
                Text(
                  "${user.address2}",
                  textAlign: TextAlign.center,
                  style: addrStyle(),
                ),
                Text(
                  " gacha",
                  style: TextStyle(
                      color: Colors.red[700], fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          greyField(
            spacingSize: spacingSize,
            width: width,
          ),
          Container(
            // height: 0.4 * width,
            margin: EdgeInsets.symmetric(horizontal: spacingSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profilTextSelect(
                  spacingSize: spacingSize,
                  text: "Profil sozlamalari",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileSettings(),
                      ),
                    );
                  },
                ),
                Divider(),
                profilTextSelect(
                  spacingSize: spacingSize,
                  text: "Marshrut sozlamalari",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddressSettings(),
                      ),
                    );
                  },
                ),
                Divider(),
                profilTextSelect(
                  spacingSize: spacingSize,
                  text: "Taklif va shikoyatlar",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Compilation()));
                  },
                ),
              ],
            ),
          ),
          greyField(spacingSize: spacingSize, width: width),
          Container(
              // height: 0.4 * width,
              margin: EdgeInsets.symmetric(horizontal: spacingSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  profilTextSelect(
                    spacingSize: spacingSize,
                    text: "Chiqish",
                    onPressed: onExitApp,
                  )
                ],
              )),
        ],
      ),
    );
  }

  TextStyle addrStyle() {
    return TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w600,
        color: Colors.black);
  }

  BoxDecoration decorationContainer(Color c) {
    return BoxDecoration(
        border: Border.all(
          width: 0.7,
          color: c,
        ),
        borderRadius: BorderRadius.circular(15));
  }
}
