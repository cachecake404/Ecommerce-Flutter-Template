import "package:flutter/foundation.dart";
import "../Tools/UserDataManager.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "Auth.dart";
import "../Widgets/ShopCard.dart";
import "./ProductsHandler.dart";
import "package:flutter/material.dart";
import "OrderManager.dart";

class DataTracker with ChangeNotifier {
  //Track Loading Objects
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Widget loadingWidget(Widget mainWidget) {
    if (_isLoading) {
      return (CircularProgressIndicator());
    } else {
      return mainWidget;
    }
  }

  //Track Products
  List<List<ShopCard>> _allCards = new List<List<ShopCard>>();
  List<List<ShopCard>> get allCards => _allCards;

  void setCards() async {
    ProductsHandler handler = new ProductsHandler();
    int n = 3; //number of types of products in data base
    for (int i = 1; i < n + 1; i++) {
      List<ShopCard> cards =
          await handler.getObject("products/type" + i.toString());

      _allCards.add(cards);
    }
  }
  // Track Orders
  List<ShopItem> _shopItems = new List<ShopItem>();
  List<ShopItem> get shopItems => _shopItems;

  // Tracking unique key associated with customer data
  String _customDataKey;
  String get customDataKey => _customDataKey;
  // Tracking customer data
  Map<String, dynamic> _customData;
  Map<String, dynamic> get customData => _customData;
  // Tracking the customer user variable
  FirebaseUser _user;
  FirebaseUser get user => _user;
  //Tracking authenthication variable for user
  Auth _auth = new Auth();
  Auth get auth => _auth;
  // Auto set data on changes.
  void autoSetData() async {
    _user = await _auth.getCurrentUser();
    UserDataManager umanager = new UserDataManager(_user);
    Map<String, dynamic> userNestedDetails = await umanager.getData();

    for (String i in userNestedDetails.keys) {
      _customDataKey = i;
    }
    _customData = userNestedDetails[_customDataKey];
  }

  // Call when auth is set
  set auth(Auth a) {
    _auth = a;
    autoSetData();
    notifyListeners();
  }
}
