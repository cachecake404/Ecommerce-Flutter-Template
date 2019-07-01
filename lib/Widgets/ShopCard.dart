import 'package:flutter/material.dart';
import "../Pages/DataPages/ProductDetails.dart";

// Widget to render a card that holds all the details of the product we want to purchase.
class ShopCard extends StatelessWidget {
  //Colors
  final Color cardBackground = Colors.deepPurple;
  final Color viewButtonColor = Color(0xFF672185);

  //final String id; // Include this in Constructor later.
  final String name; // Name of Product
  final String shortDescription; // Short Description for the Product
  final String longDescription; // Long Description for the Product
  final String imageUrl; // Image to render for the Product
  final double price; // Price for the Product

  ShopCard(String n, String sd, String ld, String url, double p)
      : this.name = n,
        this.shortDescription = sd,
        this.longDescription = ld,
        this.imageUrl = url,
        this.price = p;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardBackground,
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: 300,
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    r"$" + price.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text("  "),
              Text(
                shortDescription,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              Text("      "),
              RaisedButton(
                color: viewButtonColor,
                child: Text("View",style: TextStyle(
                        color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(this),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
