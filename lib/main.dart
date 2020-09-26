import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency/home_screen.dart';
import 'package:flutter_cryptocurrency/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackGroundColor,
      ),
      home: HomeScreen(),
    );
  }
}
