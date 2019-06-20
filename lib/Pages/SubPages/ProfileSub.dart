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
    FirebaseUser us = await Provider.of<DataTracker>(context).auth.getCurrentUser();
    setState(() {
     details = us.email; 
    });
    print(us);  
    
  }

  @override
  Widget build(BuildContext context) {
    if(initalGet==false)
    {
      getUserDetails(context);
      initalGet = true;
    }
    
    return Text(details);
  }
}
