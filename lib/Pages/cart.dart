import 'package:flutter/material.dart';
import "../Widgets/OrderCardHolder.dart";
import "package:provider/provider.dart";
import "../Tools/DataTracker.dart";

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Widget cartItemsGen(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (Provider.of<DataTracker>(context).shopItems.length == 0) {
      return Container(
        child: Column(
          children: [Text("Cart Empty")],
        ),
      );
    } else {
      return Container(height: height * 0.40, child: OrderCardHolder(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    Color appBarColor = Colors.deepPurpleAccent;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: appBarColor,
      ),
      body: ListView(
        children: [cartItemsGen(context)],
      ),
    );
  }
}
