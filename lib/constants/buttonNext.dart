import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';

class mainNextButton extends StatelessWidget {
  final Function onNext;
  const mainNextButton({
    Key key,
    this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4.0),
            ),
          ),
          onPressed: onNext,
          child: Text(
            "Keyingi",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
