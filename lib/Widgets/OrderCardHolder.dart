import 'package:flutter/material.dart';
import 'package:hookah1/Tools/OrderManager.dart';
import "package:provider/provider.dart";
import "../Tools/DataTracker.dart";

class OrderCardHolder extends StatefulWidget {
  final Function priceRedo;
  OrderCardHolder(BuildContext context, Function priceDo) : priceRedo = priceDo;
  @override
  _OrderCardHolderState createState() => _OrderCardHolderState();
}

class _OrderCardHolderState extends State<OrderCardHolder> {
  List<Card> cards = new List<Card>();
  void removeItem(BuildContext context, ShopItem shopItem) {
    Provider.of<DataTracker>(context).shopItems.remove(shopItem);
    setState(() {
      cards = genCards(context);
    });
    widget.priceRedo(context);
  }

  //      priceRedo(); call setState get from init state
  List<Card> genCards(BuildContext context) {
    return Provider.of<DataTracker>(context)
        .shopItems
        .map((shopItem) => Card(
                child: Row(
              children: <Widget>[
                Image.network(shopItem.cardItem.imageUrl,
                    height: 50, width: 50),
                Text("  " + shopItem.cardItem.name),
                Spacer(),
                Text("x" + shopItem.quantity.toString() + "  "),
                Text(r"  $" + shopItem.price.toString()),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    removeItem(context, shopItem);
                  },
                )
              ],
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    cards = genCards(context);
    return ListView.builder(
        itemBuilder: (context, index) => cards[index], itemCount: cards.length);
  }
}
