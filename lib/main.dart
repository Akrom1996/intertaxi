import 'package:flutter/material.dart';
import 'package:intertaxi/constants/colors.dart';
import 'package:intertaxi/constants/user.dart';
import 'package:intertaxi/kirish/kirish.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserRegistration())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: primaryColor),
      home: Kirish(),
    );
  }
}
