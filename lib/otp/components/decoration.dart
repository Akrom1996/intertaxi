import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorderAmber(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorderAmber(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: new BorderSide(
      color: primaryColor,
    ),
  );
}

OutlineInputBorder outlineInputBorderAmber() {
  return new OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: new BorderSide(
      color: Colors.grey[400],
    ),
  );
}
