import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// DOCUMENT THIS 
class Ordercard extends StatelessWidget {
  final String resturantName;
  final String resturantLocation;
  final String orderDeliveredTime;
  final bool delivered;
  //final ordered = [];
  static const ordered = [];
  final double totalCost;

  Ordercard(
      {this.resturantName,
      this.resturantLocation,
      this.orderDeliveredTime,
      this.delivered,
      this.totalCost});
  //add a constructor for the Ordercard class
  @override
  Widget build(BuildContext context) {
    _boxTitles(bool backgroundColor, String boxText) => FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 2.0),
          child: Text(
            "$boxText",
            style: TextStyle(
              fontSize: 50,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ));

    //used to get height and width of current screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Card(
      color: Theme.of(context).accentColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(50.0),
      // ),
      child: Container(
        height: height * 0.4,
        width: width * 0.8,
        child: Column(
          children: <Widget>[
            // SizedBox(height: height*0.03),
            Container(
              color: Theme.of(context).primaryColorLight,
              child: _boxTitles(true, resturantName),
            ),
            // SizedBox(
            //   height: height * 0.02,
            //   child: Container(
            //     decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            //   )
            // ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: _boxTitles(true, resturantLocation),
                    ),
                    Container(
                      child: _boxTitles(true, orderDeliveredTime),
                    ),
                  ],
                ),
                Container(
                  child: delivered
                      ? Image.asset(
                          "lib/Assets/order_deliverd.png",
                        )
                      : Image.asset(
                          "lib/Assets/order_not_deliverd.png",
                        ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: _boxTitles(true, totalCost.toString()),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
