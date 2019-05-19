import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ordercard extends StatelessWidget{
    
    String resturantName;
    String resturantLocation;
    String orderDeliveredTime = "-/-/- -:-";
    bool delivered = false;
    var ordered = {}; 
    double totalCost; 

    Ordercard({this.resturantName, this.resturantLocation, this.orderDeliveredTime, this.delivered, this.ordered, this.totalCost});

    @override 
    Widget build(BuildContext context) {
   
      //used to get height and width of current screen
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      return new Card(
        color: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          height: height * 0.4,
          width: width * 0.8,
        child: Column(
          children: <Widget>[
            Text("$resturantName"),
            Text("$resturantLocation"),
            Text("$orderDeliveredTime"),
            delivered ? Image.asset(
              "/Assets/order_deliverd.png",
              height: 50,
              width: 50,
              ) : 
              Image.asset(
                "/Assets/order_not_deliverd.png",
                height: 50,
                width: 50 ,
              ),
            Text("$totalCost"),
          ],
        ),
      ),
    );
  }
}