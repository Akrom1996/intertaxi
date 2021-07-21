import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegistration extends ChangeNotifier {
  String userName;
  // String familyName;
  String phoneNumber;
  String autoNumber;
  String address;
  int type;

  String address1;
  String address2;

  void setUserDirection(String add1, String add2) {
    address1 = add1;
    address2 = add2;
    notifyListeners();
  }

  void setUserInfo(Map<String, dynamic> obj) {
    type = obj["type"];
    userName = obj["userName"];
    // familyName = obj["familyName"];
    phoneNumber = obj["phoneNumber"];
    autoNumber = obj["autoNumber"];
    address = obj["address"];
    notifyListeners();
  }

  getUserInfo() {
    return <String, dynamic>{
      "type": type,
      "userName": userName,
      // "familyName": familyName,
      "phoneNumber": phoneNumber,
      "autoNumber": autoNumber,
      "address": address
    };
  }
}
