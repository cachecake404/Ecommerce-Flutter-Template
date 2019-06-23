import './HttpHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataManager {
  FirebaseUser user;
  UserDataManager(this.user);

  Future<void> postData(String name, int age) async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", "users/" + user.uid);
    Map<String, dynamic> response = await hand.addData({
      "name": name,
      "age": age,
    });
    print(response);
  }

  Future<Map<String, dynamic>> getData() async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", "users/" + user.uid);
    
    Map<String, dynamic> responseData = await hand.getData(); 
    return responseData;
  }
}
