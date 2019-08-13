import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import 'package:provider/provider.dart';

class OrderSub extends StatefulWidget {
  @override
  _OrderSubState createState() => _OrderSubState();
}

class _OrderSubState extends State<OrderSub> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(Provider.of<DataTracker>(context).orderItems);
  }

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
