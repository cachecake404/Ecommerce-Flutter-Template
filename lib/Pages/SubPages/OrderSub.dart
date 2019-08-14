import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import 'package:hookah1/Widgets/OrderedItem.dart';
import 'package:provider/provider.dart';

class OrderSub extends StatefulWidget {
  @override
  _OrderSubState createState() => _OrderSubState();
}

class _OrderSubState extends State<OrderSub> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //print(Provider.of<DataTracker>(context).orderItems);
  }

  Widget genWidget() {
    var data = Provider.of<DataTracker>(context).orderItems;
    if (data != null) {
      List<OrderedItem> processData = new List<OrderedItem>();
      data.forEach((f) => processData.add(new OrderedItem(f)));
      if (data.length != 0) {
        return Container(
            child: ListView(
          children: processData,
        ));
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return genWidget();
  }
}
