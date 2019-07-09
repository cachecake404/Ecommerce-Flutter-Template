import "../Widgets/ShopCard.dart";
import "./HttpHandler.dart";
import 'package:firebase_database/firebase_database.dart';

class ProductsHandler {
  ProductsHandler();
  Future<void> postObject(String endpoint, Map<String, dynamic> data) async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", endpoint);
    Map<String, dynamic> response = await hand.addData(data);
    print(response);
  }

  Future<List<ShopCard>> getObject(String endpoint) async {
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    DataSnapshot dataVal = await db.child("products").child(endpoint).once();
    List<dynamic> dataListTemp = dataVal.value;
    List<ShopCard> shopCards = new List<ShopCard>();
    for (var obj in dataListTemp) {
      shopCards.add(ShopCard(
          obj["name"],
          obj["shortDescrip"],
          obj["longDescrip"],
          obj["image"],
          double.parse(obj["price"].toString())));
    }

    return shopCards;
  }
}
