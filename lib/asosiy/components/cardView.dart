import 'package:flutter/material.dart';

Container cardView(double width, int index, double spacingSize) {
  return Container(
    margin:
        EdgeInsets.symmetric(vertical: 0.01 * width, horizontal: 0.01 * width),
    // height: 500,
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[400],
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: index % 4 == 0
                ? Colors.blue.withOpacity(0.8)
                : Colors.pinkAccent.withOpacity(0.8),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
              // right: Radius.circular(10)
            ),
          ),
          padding: EdgeInsets.only(right: 0.01 * width),
          height: 0.15 * width,
          child: Row(
            children: [
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              // horizontal: 0.05 * width,
              vertical: spacingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Yo'nalish:",
                    style: boldStyle(),
                  ),
                  Text(
                    "data",
                    style: dataStyle(),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Wrap(
                spacing: spacingSize,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    "E'lon vaqti:",
                    style: boldStyle(),
                  ),
                  Text(
                    "${DateTime.now().toLocal()}",
                    style: dataStyle(),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    "Jo'nash vaqti (taxminan):",
                    style: boldStyle(),
                  ),
                  Text(
                    "${DateTime.now().toLocal()}",
                    style: dataStyle(),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    "Narxi (taxminan):",
                    style: boldStyle(),
                  ),
                  Text(
                    "100000 so'm",
                    style: dataStyle(),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    "Soni:",
                    style: boldStyle(),
                  ),
                  Text(
                    "${index % 5}",
                    style: dataStyle(),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

TextStyle dataStyle() {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
}

TextStyle boldStyle() {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
}
