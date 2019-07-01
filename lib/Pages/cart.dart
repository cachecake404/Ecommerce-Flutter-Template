import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    Color appBarColor = Colors.deepPurpleAccent;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: appBarColor,
      ),
      body: ListView(
        children: [Text("Hello World")],
      ),
    );
  }
}
