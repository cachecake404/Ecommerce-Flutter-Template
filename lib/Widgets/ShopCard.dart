import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  
  //Colors
  final Color cardBackground = Colors.deepPurple;
  final Color viewButtonColor = Colors.purpleAccent;

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
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

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
          // Row(
          //   children: <Widget>[
          //     Column(
          //       children: <Widget>[Text(name), Text(price.toString())],
          //     )
          //   ],
          // ),
          // Text(shortDescription),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              
              Column(
                children: <Widget>[
                  Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
                  
                  Text(r"$"+price.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
                ],
              ),
              Text("  "),
              Text(shortDescription,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
              Text("      "),
              RaisedButton(
                color: viewButtonColor,
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
