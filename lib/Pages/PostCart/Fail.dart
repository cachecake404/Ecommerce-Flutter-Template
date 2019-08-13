import 'package:flutter/material.dart';

class Fail extends StatefulWidget {
  Fail({Key key}) : super(key: key);

  _FailState createState() => _FailState();
}

class _FailState extends State<Fail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fail"),
      ),
      body: ListView(
        children: <Widget>[Center(child: Text("Fail"))],
      ),
    );
  }
}