import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';

class regButton extends StatelessWidget {
  final Function onPressedBtn;
  final textBtn;
  final iconBtn;
  final color;
  const regButton({
    Key key,
    @required this.onPressedBtn,
    @required this.textBtn,
    @required this.iconBtn,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              primary: color,
              // elevation: 1,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              side: BorderSide(
                  width: 0.8,
                  color: primaryColor, //Theme.of(context).accentColor,
                  style: BorderStyle.solid),
              textStyle: TextStyle(fontSize: 16, color: Colors.black54)),
          onPressed: onPressedBtn,
          child: Row(
            children: [
              iconBtn == null
                  ? SizedBox(
                      width: 0,
                      height: 30,
                    )
                  : Icon(
                      iconBtn,
                      size: 30,
                      color: Colors.black87,
                    ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Text(
                textBtn,
                style: TextStyle(fontSize: 20, color: Colors.black87),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )),
    );
  }
}
