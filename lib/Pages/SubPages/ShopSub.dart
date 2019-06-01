import 'package:flutter/material.dart';
import "../../Widgets/ShopCard.dart";
import "../../Widgets/ShopCardHolder.dart";

class ShopSub extends StatelessWidget {
  List<ShopCard> sampleGen(int n) {
    ShopCard sample = ShopCard(
        "Tripy Wirpy",
        "Good Shit",
        "Really Good Shit",
        "http://digitalimagemakerworld.com/images/crazy-pic/37943628-crazy-pic.jpg",
        19);
    List<ShopCard> sampleData = new List<ShopCard>();
    for (int i = 0; i < n; i++) {
      sampleData.add(sample);
    }
    if (sampleData == null) {
      print("NULL");
    }
    return sampleData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ShopCardHolder("Type I", sampleGen(10)),
          ShopCardHolder("Type II", sampleGen(10)),
          ShopCardHolder("Type III", sampleGen(10))
        ],
      ),
    );
  }
}
