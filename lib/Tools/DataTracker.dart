import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
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

  Widget loadingWidget(bool giveEmpty, Widget mainWidget) {
    if (_isLoading) {
      return (giveEmpty ? Container() : CircularProgressIndicator());
    } else {
      return mainWidget;
    }
  }

  //Track Products
  List<List<ShopCard>> _allCards = new List<List<ShopCard>>();
  List<List<ShopCard>> get allCards => _allCards;
  
  List<String> _titles = new List<String>();
  List<String> get titles => _titles;

  int _numTitles;
  int get numTitles => _numTitles;

  Future<List<String>> getTitles() async {
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    DataSnapshot dataVal = await db.child("titles").once();
    List<String> data = List<String>.from(dataVal.value);
    return data;
  }

  void setCards() async {
    ProductsHandler handler = new ProductsHandler();
    int vnumber = await handler.getNumber();
    List<String> titlesData = await getTitles();
    _numTitles = vnumber;
    _titles = titlesData;
    int n = vnumber; //number of types of products in data base
    for (int i = 1; i < n + 1; i++) {
      List<ShopCard> cards = await handler.getObject("type" + i.toString());

      _allCards.add(cards);
    }
  }

  // Track Orders
  List<ShopItem> _shopItems = new List<ShopItem>();
  List<ShopItem> get shopItems => _shopItems;
  set shopItems(List<ShopItem> data) {
    _shopItems = data;
    notifyListeners();
  }

  // Track Online Ordered Items
  List<Map<String, dynamic>> _orderItems = new List<Map<String, dynamic>>();
  List<Map<String, dynamic>> get orderItems => _orderItems;

  void setOrderData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot dataTemp = await Firestore.instance
        .collection("cards")
        .document(user.uid)
        .collection("orders")
        .limit(100)
        .getDocuments();
    _orderItems.clear();
    dataTemp.documents.forEach((f) => _orderItems.add(f.data));
  }

  // Tracking customer data
  Map<String, dynamic> _customData;
  Map<String, dynamic> get customData => _customData;
  // Tracking the customer user variable
  FirebaseUser _user;
  FirebaseUser get user => _user;
  //Tracking authenthication variable for user
  Auth _auth = new Auth();
  Auth get auth => _auth;
  // Checker for getting additional details
  bool _needData = true;
  bool get needData => _needData;
  set needData(bool value) {
    _needData = value;
    notifyListeners();
  }

  // Auto set data on changes.
  Future<void> autoSetData() async {
    _user = await _auth.getCurrentUser();
    UserDataManager umanager = new UserDataManager(_user);
    Map<String, dynamic> userNestedDetails = await umanager.getData();
    if (userNestedDetails != null) {
      _customData = userNestedDetails;
      _needData = false;
    }
  }

  // Call when auth is set
  set auth(Auth a) {
    _auth = a;
    notifyListeners();
  }
}
