import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/regionData.dart';

class MyDialog extends StatefulWidget {
  final region;
  final currentValue;
  final index_A;
  final index_B;
  final selectedRegion_A;
  final selectedRegion_B;
  final selected_A;
  final selected_B;
  final controller;
  const MyDialog({
    Key key,
    this.region,
    this.currentValue,
    this.index_A,
    this.index_B,
    this.selectedRegion_A,
    this.selectedRegion_B,
    this.selected_A,
    this.selected_B,
    this.controller,
  }) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Tuman(lar)ni tanlang",
        style: TextStyle(
            color: Colors.grey[900], fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
            itemBuilder: (context, index) {
              var data =
                  cities[widget.region == 1 ? widget.index_A : widget.index_B][
                      widget.region == 1
                          ? widget.selectedRegion_A
                          : widget.selectedRegion_B];
              return ListTile(
                leading: Checkbox(
                  value: widget.currentValue[index],
                  onChanged: (value) {
                    // print(value.toString() + " " + region.toString());

                    // setState(() {
                    //   if (widget.region == 1) {
                    //     widget.selected_A[index] = value;
                    //   } else {
                    //     widget.selected_B[index] = value;
                    //   }
                    // });
                    setState(() {
                      widget.currentValue[index] = value;
                      // print("current val ${widget.currentValue}");
                      // widget.region == 1
                      // ?
                      //  widget.controller.text += data[index] + ", "
                      // :
                      widget.controller.text += data[index] + ", ";
                    });
                  },
                  activeColor: primaryColor,
                ),
                title: Text(
                  "${data[index]}",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount:
                cities[widget.region == 1 ? widget.index_A : widget.index_B][
                        widget.region == 1
                            ? widget.selectedRegion_A
                            : widget.selectedRegion_B]
                    .length),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Tanlash",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
  }
}
