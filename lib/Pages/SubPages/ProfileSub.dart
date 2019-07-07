import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../../Tools/DataTracker.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "ProfileHelperPages/AccountDetails.dart";

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
      details = userDetails["first_name"] +
          "\n" +
          userDetails["last_name"] +
          "\n" +
          userDetails["address"] +
          "\n" +
          us.email +
          "\n" +
          userDetails["phone"] +
          "\n" +
          userDetails["age"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    //used to get height and width of current screen
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView(
      children: <Widget>[
        Container(
          height: height * 0.05,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountDetails(),
                ),
              );
            },
            child: Card(
              child: Text("Account Details"),
            ),
          ),
        ),
        Container(
          height: height * 0.01,
        ),
        Container(
          height: height * 0.05,
          child: Card(
            child: Text("Reset Password"),
          ),
        ),
        Container(
          height: height * 0.01,
        ),
        Container(
          height: height * 0.05,
          child: Card(
            child: Text("Support"),
          ),
        ),
      ],
    );
  }
}
