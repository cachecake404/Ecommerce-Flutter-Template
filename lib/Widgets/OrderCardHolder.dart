import 'package:flutter/material.dart';
import "../Tools/OrderManager.dart";
import "package:provider/provider.dart";
import "../Tools/DataTracker.dart";

class OrderCardHolder extends StatelessWidget {
  final List<ShopItem> items;
  OrderCardHolder(BuildContext context): items = Provider.of<DataTracker>(context).shopItems;
  @override
  Widget build(BuildContext context) {
    List<Card> cards = items
        .map((shopItem) => Card(
                child: Row(
              children: <Widget>[
                Image.network(shopItem.cardItem.imageUrl,height:50,width:50),
                Text("  "+shopItem.cardItem.name),
                Spacer(),
                Text("x" + shopItem.quantity.toString()+"  "),
                Text(r"  $" + shopItem.price.toString())
              ],
            )))
        .toList();
    return ListView(children: cards);
  }
}
