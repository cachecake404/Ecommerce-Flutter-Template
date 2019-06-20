import "package:flutter/foundation.dart";
import "Auth.dart";

class DataTracker with ChangeNotifier {
  //Tracking authenthication variable for user
  Auth _auth = new Auth();
  Auth get auth => _auth;

  set auth(Auth a) {
    _auth = a;
    notifyListeners();
  }
}
