import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intertaxi/asosiy/components/textSelection.dart';
import 'package:intertaxi/asosiy2/components/greyField.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/manzilSozlamalar/addressSettings.dart';
import 'package:intertaxi/shikoyat/compilation.dart';
import 'package:intertaxi/sozlamalar/profileSettings.dart';
import 'package:provider/provider.dart';

class MainConsumer extends StatefulWidget {
  const MainConsumer({Key key}) : super(key: key);

  @override
  _MainConsumerState createState() => _MainConsumerState();
}

class _MainConsumerState extends State<MainConsumer> {
  var user;

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
        title: Text(
          "Inter Taxi",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 0.3 * width,
                margin: EdgeInsets.symmetric(
                    horizontal: spacingSize, vertical: 0.03 * width),
                // decoration: decorationContainer(Colors.grey),
                child: Stack(
                  children: [
                    PageView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 1),
                        itemBuilder: (context, index) {
                          return Image.asset("./assets/png/profile1.png");
                        }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 0.025 * width,
                        height: 0.025 * width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
                // Text("ss"),
              )
            ],
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (context, controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    width: double.infinity,
                    height: 0.5 * width,
                    child: ListView.builder(
                      controller: controller,
                      itemBuilder: (context, index) {
                        return ListTile(title: Center(child: Text("$index")));
                      },
                      itemCount: 10,
                    ),
                  ),
                );
              })
        ],
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
                  text: "Taklif va shikoyatlar",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Compilation()),
                    );
                  },
                )
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

  OutlineInputBorder enabledInputBorder() {
    return new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(10.0),
      borderSide: new BorderSide(
        color: Colors.grey,
      ),
    );
  }
}
