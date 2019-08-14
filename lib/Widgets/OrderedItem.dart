import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import 'package:hookah1/Tools/OrderManager.dart';
import 'package:hookah1/Widgets/ShopCard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderedItem extends StatelessWidget {
  final Map<String, dynamic> data;
  OrderedItem(this.data);
  String getDate() {
    var date = DateTime.parse(data["date"]);
    DateFormat formatter = new DateFormat('MM-dd-yyyy');
    String formatedString = formatter.format(date);
    print(formatedString);
    return formatedString;
  }

  String getPrice() {
    double price = data["price"];
    String n = r"$" + price.toStringAsFixed(2);
    return n;
  }

  List<ShopItem> getShopItems()
  {
    List<ShopItem> finalItems = new List<ShopItem>();
    for(var i in data["items"])
    {
      ShopCard cardItem = new ShopCard(i["name"],i["shortDescription"],i["longDescription"],i["imageUrl"],i["price"]);
      ShopItem sItem = new ShopItem(cardItem,i["quantity"],i["Tprice"]);
      finalItems.add(sItem);
    }
    return finalItems;
  }
  void setCart(BuildContext context)
  {
    Provider.of<DataTracker>(context).shopItems.clear();
    Provider.of<DataTracker>(context).shopItems  = getShopItems();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: <Widget>[
        Icon(Icons.smoking_rooms),
        Text("    "),
        Text(getDate()),
        Text("    "),
        Text(getPrice()),
        Text("                                "),
        RaisedButton(
          onPressed: () {
            setCart(context);
            Navigator.pushNamed(context, "/cart");
          },
          child: Text(
            "Reorder",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ));
  }
}
