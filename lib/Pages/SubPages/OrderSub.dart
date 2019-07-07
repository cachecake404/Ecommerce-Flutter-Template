import 'package:flutter/material.dart';

class OrderSub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You Have Made No Orders  "),
            Icon(Icons.remove_shopping_cart)
          ],
        ),
      ],
    );
  }
}
