import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderedItem extends StatelessWidget {
  final Map<String, dynamic> data;
  OrderedItem(this.data);
  String getDate() {
    var date = DateTime.parse(data["date"]);
    DateFormat formatter = new DateFormat('MM-dd-yyyy');
    String formatedString = formatter.format(date);
    print(formatedString);
    return formatedString;
  }

  String getPrice() {
    double price = data["price"];
    String n = r"$" + price.toStringAsFixed(2);
    return n;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: <Widget>[
        Icon(Icons.smoking_rooms),
        Text("    "),
        Text(getDate()),
        Text("    "),
        Text(getPrice()),
        Text("        "),
        RaisedButton(
          onPressed: () {},
          child: Text(
            "View",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text("  "),
        RaisedButton(
          onPressed: () {},
          child: Text(
            "Reorder",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ));
  }
}
