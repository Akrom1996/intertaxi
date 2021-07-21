import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/registratsiya2/components/decoration.dart';

class inputField extends StatelessWidget {
  final hintText;
  final ValueChanged<String> callback;
  final ValueChanged<String> validate;
  final controllerText;
  final isName;
  final prefixIcon;
  final isNumber;
  const inputField({
    Key key,
    @required this.width,
    @required this.hintText,
    @required this.callback,
    @required this.controllerText,
    @required this.isName,
    @required this.prefixIcon,
    @required this.validate,
    @required this.isNumber,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: 0.1 * width,
            vertical: isName || isNumber ? 0.01 * width : 0.03 * width),
        child: TextFormField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          validator: validate,
          cursorColor: primaryColor,
          maxLength: isName
              ? 20
              : isNumber
                  ? 9
                  : null,
          style: TextStyle(fontSize: 18),
          decoration:
              decoration(hintText, prefixIcon == null ? null : prefixIcon),
          controller: controllerText,
          onChanged: (txt) {
            callback(txt);
          },
        ));
  }
}
