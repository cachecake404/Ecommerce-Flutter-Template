import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  
  //Colors
  final Color cardBackground = Colors.white;

  //final String id; // Include this in constructor later.
  final String name;
  final String shortDescription;
  final String longDescription;
  final String imageUrl;
  final double price;

  ShopCard(String n, String sd, String ld, String url, double p)
      : this.name = n,
        this.shortDescription = sd,
        this.longDescription = ld,
        this.imageUrl = url,
        this.price = p;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

    return Card(
      color: cardBackground,
      child: Column(
        children: <Widget>[
          Image.network(
            imageUrl,
            width: width * 0.4955,
          ),
          // Row(
          //   children: <Widget>[
          //     Column(
          //       children: <Widget>[Text(name), Text(price.toString())],
          //     )
          //   ],
          // ),
          // Text(shortDescription),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(name),
                  Text(r"$"+price.toString()),
                ],
              ),
              Text("  "),
              Text(shortDescription),
              Text("  "),
              RaisedButton(
                child: Text("View"),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
