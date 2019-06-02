import 'package:flutter/material.dart';
import "../../Widgets/ShopCard.dart";
import "../../Widgets/ShopCardHolder.dart";

class ShopSub extends StatelessWidget {
  List<ShopCard> sampleGen(int n) {
    ShopCard sample = ShopCard(
        "Tripy Wirpy",
        "Blah Blah Blah\nBlah Blah Blah\nBlah Blah Blah",
        "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah!",
        "http://digitalimagemakerworld.com/images/crazy-pic/37943628-crazy-pic.jpg",
        19);
    ShopCard sample2 = ShopCard(
        "Zen Wen",
        "Blah Blah Blah\nBlah Blah Blah\nBlah Blah Blah",
        "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah!",
        "http://inspirationfeed.com/wp-content/uploads/2010/06/1024x1024_Dizorb_UU_Theory_HD_Wallpaper-500x500.jpg",
        12);
    List<ShopCard> sampleData = new List<ShopCard>();
    for (int i = 0; i < n; i++) {
      sampleData.add(sample);
      sampleData.add(sample2);
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
