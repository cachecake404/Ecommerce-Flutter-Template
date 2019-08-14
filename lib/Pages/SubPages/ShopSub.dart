import 'package:hookah1/Tools/DataTracker.dart';
import 'package:flutter/material.dart';
import "../../Widgets/ShopCardHolder.dart";
import "package:provider/provider.dart";

class ShopSub extends StatefulWidget {
  @override
  _ShopSubState createState() => _ShopSubState();
}

class _ShopSubState extends State<ShopSub> {
  
  List<ShopCardHolder> genCards(BuildContext context) {
    List<ShopCardHolder> holder = new List<ShopCardHolder>();
    for (int i = 0; i < Provider.of<DataTracker>(context).numTitles; i++) {
      ShopCardHolder item = new ShopCardHolder(
          Provider.of<DataTracker>(context).titles[i],
          Provider.of<DataTracker>(context).allCards[i]);
      holder.add(item);
    }
    return holder;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(shrinkWrap: true, children: genCards(context)),
    );
  }
}
