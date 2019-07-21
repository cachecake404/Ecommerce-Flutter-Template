import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class StripeManager {
  static void addCard(String uid, String token) async {
    await Firestore.instance
        .collection("cards")
        .document(uid)
        .updateData({"custId": "new"});
    Firestore db = Firestore.instance;
    await db
        .collection('cards')
        .document(uid)
        .collection('tokens')
        .add({'tokenID': token});
  }

  static void chargeCustomer(String uid, String cusID, double price) async {
    double bottomPrice = price.floorToDouble();
    double trueDiff = price - price.floorToDouble();
    double diff = (trueDiff * 100).ceilToDouble();
    int realPrice = ((bottomPrice * 100) + (diff)).toInt();
    Firestore.instance
        .collection("cards")
        .document(uid)
        .collection("charges")
        .add({
      "currency": "usd",
      "amount": realPrice,
      "description": "Product Purchased"
    });
  }
}
