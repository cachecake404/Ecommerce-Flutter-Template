import "package:flutter/foundation.dart";
import "../Tools/UserDataManager.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "Auth.dart";

class DataTracker with ChangeNotifier {
  //Tracking authenthication variable for user
  String _customDataKey;
  String get customDataKey => _customDataKey;
  
  Map<String,dynamic> _customData;
  Map<String,dynamic> get customData => _customData;

  FirebaseUser _user;
  FirebaseUser get user => _user;

  Auth _auth = new Auth();
  Auth get auth => _auth;
  
  void autoSetData() async
  {
     _user = await _auth.getCurrentUser();
     UserDataManager umanager = new UserDataManager(_user);
     Map<String,dynamic> userNestedDetails = await umanager.getData();
     print(userNestedDetails);
     for(String i in userNestedDetails.keys){_customDataKey=i;}
     _customData = userNestedDetails[_customDataKey]; 
  }

  set auth(Auth a)  {
    _auth = a;
    autoSetData();
    notifyListeners();
  }
}
