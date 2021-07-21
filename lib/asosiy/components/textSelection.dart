import 'package:flutter/material.dart';

class profilTextSelect extends StatelessWidget {
  final text;
  final Function onPressed;
  const profilTextSelect({
    Key key,
    @required this.spacingSize,
    this.text,
    this.onPressed,
  }) : super(key: key);

  final double spacingSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // focusColor: Colors.transparent,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "$text",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: spacingSize,
            ),
          ],
        ),
      ),
    );
  }
}
