import 'package:hookah1/Tools/DataTracker.dart';
import 'package:flutter/material.dart';
import "../../Widgets/ShopCardHolder.dart";
import "package:provider/provider.dart";

class ShopSub extends StatefulWidget {
  @override
  _ShopSubState createState() => _ShopSubState();
}

class _ShopSubState extends State<ShopSub> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ShopCardHolder(
              "Type I", Provider.of<DataTracker>(context).allCards[0]),
          ShopCardHolder(
              "Type II", Provider.of<DataTracker>(context).allCards[1]),
          ShopCardHolder(
              "Type III", Provider.of<DataTracker>(context).allCards[2])
        ],
      ),
    );
  }
}
