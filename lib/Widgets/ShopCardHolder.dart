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
