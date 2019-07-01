import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import "../../Widgets/ShopCard.dart";
import "package:provider/provider.dart";
import "../../Tools/OrderManager.dart";

class ProductDetails extends StatefulWidget {
  final ShopCard cardObj;

  ProductDetails(ShopCard obj) : this.cardObj = obj;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quan = 1;
  double price;
  @override
  initState() {
    super.initState();
    price = widget.cardObj.price;
  }

  void quanManage(bool add) {
    if (add) {
      setState(() {
        quan += 1;
        price = widget.cardObj.price * quan;
      });
    }
    if (quan > 1 && add == false) {
      setState(() {
        quan -= 1;
        price = widget.cardObj.price * quan;
      });
    }
  }

  void pushItems(BuildContext context) {
    ShopItem itemObj = new ShopItem(widget.cardObj, quan, price);
    Provider.of<DataTracker>(context).shopItems.add(itemObj);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //Colors
    Color appBarColor = Colors.deepPurple;
    Color arButtonColor = Colors.deepPurple;
    Color cartButtonColor = Colors.deepPurple;
    Color cartButtonContentColor = Colors.white;
    //used to get height and width of current screen
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardObj.name + " Details"),
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.725,
            child: ListView(
              children: <Widget>[
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(widget.cardObj.imageUrl),
                      Text(widget.cardObj.name),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Text(widget.cardObj.longDescription),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.08,
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            color: arButtonColor,
                          ),
                          onPressed: () {
                            quanManage(false);
                          }),
                      Spacer(),
                      Text(quan.toString()),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: arButtonColor,
                          ),
                          onPressed: () {
                            quanManage(true);
                          }),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              height: height * 0.09,
              child: Card(
                color: cartButtonColor,
                child: InkWell(
                  onTap: () {
                    pushItems(context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: cartButtonContentColor,
                          ),
                          Spacer(),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: cartButtonContentColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            r"$" + price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: cartButtonContentColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
