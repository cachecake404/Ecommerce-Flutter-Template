import 'package:flutter/material.dart';
import "Pages/shop.dart";
import "Pages/prelogin.dart";
import "Pages/login.dart";


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Color(0xff551a8b),
        accentColor: Color(0xffc0c0c0), 
      ),
      //home: Login(),
      home: Prelogin(),
      //home: Shop()
    );
  }
}
