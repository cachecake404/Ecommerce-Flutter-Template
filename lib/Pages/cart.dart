import 'package:flutter/material.dart';
import "../Widgets/OrderCardHolder.dart";
import "package:provider/provider.dart";
import "../Tools/DataTracker.dart";

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  //Colors
  Color appBarColor = Colors.deepPurpleAccent;
  Color orderCardsContainer = Colors.grey[200];
  Color priceInfoColor = Colors.deepPurple[50];
  Color checkOutColor = Colors.deepPurple;
  // Create Widget To Hold Price Info
  Widget priceContainer;

  void renderPrice(BuildContext context) {
    setState(() {
      priceContainer = genPrice(context);
    });
  }

  Widget genPrice(BuildContext context) {
    double itemPriceTotal = 0;
    for (var i in Provider.of<DataTracker>(context).shopItems) {
      itemPriceTotal += (i.price);
    }
    double taxRate = itemPriceTotal * 0.0625;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.10,
      child: Card(
        color: priceInfoColor,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Items Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(r'$' + itemPriceTotal.toString())
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Tax: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(r'$' + taxRate.toString())
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Grand Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(r'$' + (itemPriceTotal + taxRate).toString())
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cartItemsGen(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (Provider.of<DataTracker>(context).shopItems.length == 0) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.shopping_cart),Text("  Cart Empty  ")],
            )
          ],
        ),
      );
    } else {
      return ListView(
        children: <Widget>[
          Container(
            height: height * 0.40,
            child: OrderCardHolder(context, renderPrice),
            color: orderCardsContainer,
          ),
          Container(
            height: height * 0.32,
          ),
          priceContainer,
          Container(
            height: height * 0.08,
            child: GestureDetector(
              child: Card(
                color: checkOutColor,
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    priceContainer = genPrice(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: appBarColor,
      ),
      body: cartItemsGen(context),
    );
  }
}
