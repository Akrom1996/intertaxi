import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';

InputDecoration decoration(hint) {
  return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      hintText: hint,
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(10.0),
        borderSide: new BorderSide(
          color: primaryColor,
        ),
      ),
      enabledBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(10.0),
        borderSide: new BorderSide(
          color: Colors.grey[400],
        ),
      ),
      errorBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(10.0),
        borderSide: new BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(10.0),
        borderSide: new BorderSide(
          color: primaryColor,
        ),
      ));
}
