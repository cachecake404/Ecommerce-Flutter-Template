import 'package:flutter/material.dart';
import "../Widgets/OrderCardHolder.dart";
import "package:provider/provider.dart";
import "../Tools/DataTracker.dart";
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

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
  Color timePickColor = Colors.white;
  // Create Widget To Hold Price Info
  Widget priceContainer;
  // Widget to Store Delivery Time
  DateTime deliveryTime = DateTime.now();
  void renderPrice(BuildContext context) {
    setState(() {
      priceContainer = genPrice(context);
    });
  }

  String clockText() {
    if(deliveryTime == DateTime.now())
    {
      return "Now";
    }
    else
    {
      return DateFormat("MM-dd-yyyy\nhh:mm a").format(deliveryTime);
    }
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

  void setTime() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      if (DateTime.now().compareTo(date) > 0) {
        date = DateTime.now();
      }
      setState(() {
       deliveryTime = date; 
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
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
              children: <Widget>[
                Icon(Icons.shopping_cart),
                Text("  Cart Empty  ")
              ],
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
            height: height * 0.22,
          ),
          priceContainer,
          Container(
            height: height * 0.08,
            child: GestureDetector(
              onTap: () {
                setTime();
              },
              child: Card(
                color: timePickColor,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Text(clockText()),
                  ],
                ),
              ),
            ),
          ),
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
