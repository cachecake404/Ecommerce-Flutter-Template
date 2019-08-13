import 'package:flutter/material.dart';

class Finished extends StatefulWidget {
  final String chargeID;
  Finished(this.chargeID);

  _FinishedState createState() => _FinishedState();
}

class _FinishedState extends State<Finished> {
  String orderID;
  String eta = "12";
  @override
  void initState() {
    orderID = widget.chargeID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text("Thank you for your purchase\n\nYour order ID is " +
                  orderID +
                  "\n\nYour order will arive in approximately " +
                  eta +
                  " minutes."))
        ],
      ),
    );
  }
}
