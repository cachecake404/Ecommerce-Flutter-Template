import './HttpHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserDataManager {
  FirebaseUser user;
  UserDataManager(this.user);

  Future<void> postData(Map<String, dynamic> m) async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", "users/" + user.uid);
    Map<String, dynamic> response = await hand.addData(m);
    print(response);
  }

  Future<Map<String, dynamic>> getData() async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", "users/" + user.uid);

    Map<String, dynamic> responseData = await hand.getData();
    return responseData;
  }

  // After calling updateData must call Provider<DataTracker> autoSetData function to reflect changes on UI
  Future<void> updateData(Map<String, dynamic> m, String key) async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", "users/" + user.uid);
    Map<String, dynamic> response = await hand.updateData(m, key);
    print(response);
  }
}
