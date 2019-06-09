import "../../Tools/HttpHandler.dart";
import 'package:flutter/material.dart';
import "../../Widgets/ShopCard.dart";
import "../../Widgets/ShopCardHolder.dart";

class ShopSub extends StatefulWidget {
  @override
  _ShopSubState createState() => _ShopSubState();
}

class _ShopSubState extends State<ShopSub> {
  List<List<ShopCard>> typeFilter = new List<List<ShopCard>>();
  bool initialUpdate = false;

  Future<void> postObject(String endpoint) async {
    ShopCard sample = ShopCard(
        "Tripy Wirpy",
        "Blah Blah Blah\nBlah Blah Blah\nBlah Blah Blah",
        "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah!",
        "http://digitalimagemakerworld.com/images/crazy-pic/37943628-crazy-pic.jpg",
        19);
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", endpoint);
    Map<String, dynamic> response = await hand.addData({
      "name": sample.name,
      "shortDescrip": sample.shortDescription,
      "longDescrip": sample.longDescription,
      "price": sample.price,
      "image": sample.imageUrl
    });
    print(response);
  }

  Future<List<ShopCard>> getObjects(String endPoint, int endPointN) async {
    List<ShopCard> sampleData = new List<ShopCard>();
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", endPoint);
    Map<String, dynamic> response = await hand.getData();
    List<Map<String, dynamic>> bodyList = new List<Map<String, dynamic>>();
    response.forEach((key, body) => (bodyList.add(body)));
    for (var body in bodyList) {
      ShopCard sample = ShopCard(body["name"], body["shortDescrip"],
          body["longDescrip"], body["image"], body["price"]);
      sampleData.add(sample);
    }
    setState(() {
      typeFilter[endPointN - 1] = sampleData;
      print("DONE UPDATING LIST");
    });

    return sampleData;
  }

  @override
  Widget build(BuildContext context) {
    //Post Objects here uncomment to post
    //postObject("Type3");

    // Add Filters here by calling getobjects after posting them
    if (initialUpdate == false) {
      int n = 3; // Number of filters you want
      for (int i = 0; i < n; i++) {
        typeFilter.add(new List<ShopCard>());
        getObjects("Type" + (i + 1).toString(), i + 1);
      }
      initialUpdate = true;
    }

    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ShopCardHolder("Type I", typeFilter[0]),
          ShopCardHolder("Type II", typeFilter[1]),
          ShopCardHolder("Type III", typeFilter[2])
        ],
      ),
    );
  }
}
