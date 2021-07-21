import 'package:flutter/material.dart';

class greyField extends StatelessWidget {
  final spacingSize;
  final width;
  const greyField({
    Key key,
    @required this.spacingSize,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          // horizontal: spacingSize,
          vertical: spacingSize),
      color: Colors.grey[200],
      height: 0.06 * width,
      width: double.infinity,
    );
  }
}
