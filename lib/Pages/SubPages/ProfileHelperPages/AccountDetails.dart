import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import "package:provider/provider.dart";

class AccountDetails extends StatefulWidget {
  AccountDetails();

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  String fname;
  String lname;
  String phone;
  String address;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    DataTracker dataManager = Provider.of<DataTracker>(context);
    Map<String, dynamic> userDetails = dataManager.customData;
    fname = userDetails["first_name"];
    lname = userDetails["last_name"];
    phone = userDetails["phone"];
    address = userDetails["address"];
  }

  Widget readOnlyView(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: <Widget>[
        Container(
          height: height * 0.10,
          child: Card(
            child: Row(
              children: <Widget>[Text("First Name:"), Spacer(), Text(fname)],
            ),
          ),
        ),
        Container(
          height: height * 0.10,
          child: Card(
            child: Row(
              children: <Widget>[Text("Last Name:"), Spacer(), Text(lname)],
            ),
          ),
        ),
        Container(
          height: height * 0.10,
          child: Card(
            child: Row(
              children: <Widget>[Text("Phone:"), Spacer(), Text(phone)],
            ),
          ),
        ),
        Container(
          height: height * 0.10,
          child: Card(
            child: Row(
              children: <Widget>[Text("Address:"), Spacer(), Text(address)],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Colors
    Color appBarColor = Colors.deepPurple;
    //used to get height and width of current screen

    return Scaffold(
        appBar: AppBar(
          title: Text("Account Details"),
          backgroundColor: appBarColor,
        ),
        body: readOnlyView(context));
  }
}
