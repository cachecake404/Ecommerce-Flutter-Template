import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../../Tools/DataTracker.dart";
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSub extends StatefulWidget {
  @override
  _ProfileSubState createState() => _ProfileSubState();
}

class _ProfileSubState extends State<ProfileSub> {
  String details = "Hello";

  bool initalGet = false;
  void getUserDetails(BuildContext context) async {
    DataTracker dataManager = Provider.of<DataTracker>(context);
    FirebaseUser us = dataManager.user;

    Map<String, dynamic> userDetails = dataManager.customData;
    setState(() {
      details = userDetails["name"] +
          "\n" +
          userDetails["age"].toString() +
          "\n" +
          us.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (initalGet == false) {
      getUserDetails(context);
      initalGet = true;
    }

    return Text(details);
  }
}
