import 'package:flutter/material.dart';
import './ShopCard.dart';

// A widget to hold all the shop cards which we can side scroll through
class ShopCardHolder extends StatelessWidget {
  final String title; // Takes in the title for the shop card holder
  final List<ShopCard> cards; // Holds all the shops cards
  ShopCardHolder(String t, List<ShopCard> cardz)
      : title = t,
        cards = cardz;

  @override
  Widget build(BuildContext context) {
    //Colors
    Color titleColor = Colors.deepPurple; 

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " " + title,
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 22, color: titleColor),
          ),
          SizedBox(
            height: 260,
            width: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return (cards[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
