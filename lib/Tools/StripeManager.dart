import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StripeManager {
  static void addCard(String token) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore db = Firestore.instance;
    await db
        .collection('cards')
        .document(user.uid)
        .collection('tokens')
        .add({'tokenID': token});
  }
}
