import 'package:flutter/material.dart';
import './ShopCard.dart';

class ShopCardHolder extends StatelessWidget {
  final String title;
  final List<ShopCard> cards;
  ShopCardHolder(String t, List<ShopCard> cardz)
      : title = t,
        cards = cardz;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        
        children: <Widget>[
          Text(title),
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
