import 'package:flutter/material.dart';

class directionContainer extends StatelessWidget {
  final controller1;
  final controller2;
  final Function onTappedContainer1;
  final Function onTappedContainer2;

  final hint1;
  final hint2;
  final city_index;
  final selected;

  const directionContainer(
      {Key key,
      @required this.hint1,
      @required this.hint2,
      @required this.city_index,
      @required this.selected,
      @required this.controller1,
      @required this.onTappedContainer1,
      @required this.controller2,
      @required this.onTappedContainer2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 3),
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400],
            width: 0.7,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 0.05 * width, vertical: 0.03 * width),
            child: TextFormField(
              controller: controller1,
              onTap: onTappedContainer1,
              autofocus: false,
              readOnly: true,
              cursorHeight: 32,
              textAlign: TextAlign.left,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0.06 * width,
                ),
                enabledBorder: enabledInputBorder(),
                focusedErrorBorder: enabledInputBorder(),
                focusedBorder: enabledInputBorder(),
                hintText: hint1,
                // labelText: "Viloyat birinchi",
                // hintStyle: TextStyle(color: primaryColor),
                // labelStyle: TextStyle(color: primaryColor),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 0.05 * width, vertical: 0.03 * width),
            child: TextFormField(
              controller: controller2,
              onTap: controller1.text == "" ? null : onTappedContainer2,
              autofocus: false,
              readOnly: true,
              cursorHeight: 32,
              textAlign: TextAlign.left,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0.06 * width,
                ),
                enabledBorder: enabledInputBorder(),
                focusedErrorBorder: enabledInputBorder(),
                focusedBorder: enabledInputBorder(),
                hintText: hint2,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder enabledInputBorder() {
  return new OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: new BorderSide(
      color: Colors.grey,
    ),
  );
}
