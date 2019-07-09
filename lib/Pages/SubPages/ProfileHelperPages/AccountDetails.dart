import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import "package:provider/provider.dart";
import "../../../Tools/TextValidator.dart";
import "../../../Tools/UserDataManager.dart";

class AccountDetails extends StatefulWidget {
  AccountDetails();

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  String fname, lname, phone, address;
  int age;
  bool readOnly = true;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  //Colors
  Color appBarColor = Colors.deepPurple;
  Color changeButtonColor = Colors.red;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DataTracker dataManager = Provider.of<DataTracker>(context);
    Map<String, dynamic> userDetails = dataManager.customData;
    fname = userDetails["first_name"];
    lname = userDetails["last_name"];
    phone = userDetails["phone"];
    address = userDetails["address"];
    age = userDetails["age"];
  }

  // Sample Function To Update Data
  void updateSample(BuildContext context) async {
    // Get current data to change and update
    DataTracker dataManager = Provider.of<DataTracker>(context);
    UserDataManager userHandler = new UserDataManager(dataManager.user);
    Map<String, dynamic> updatedData = dataManager.customData;
    // Data to update
    updatedData["first_name"] = fname;
    updatedData["last_name"] = lname;
    updatedData["phone"] = phone;
    updatedData["address"] = address;
    updatedData["age"] = age;
    // Submit the update
    await userHandler.updateData(updatedData);
    dataManager.autoSetData();
  }

  void changeRead() {
    setState(() {
      readOnly = false;
    });
  }

  void onConfirm(BuildContext context) {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      updateSample(context);
      Navigator.pop(context);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  InputDecoration textDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
    );
  }

  Widget readOnlyView(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (readOnly) {
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
          ),
          Container(
            height: height * 0.12,
            child: GestureDetector(
              onTap: () {
                changeRead();
              },
              child: Card(
                color: changeButtonColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Change Details",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Form(
        key: _key,
        autovalidate: _validate,
        child: ListView(
          children: <Widget>[
            Container(
              height: height * 0.10,
              child: Card(
                child: new TextFormField(
                  decoration: textDecoration("Enter your first name"),
                  initialValue: fname,
                  validator: TextVaildator.validateName,
                  onSaved: (String val) {
                    fname = val;
                  },
                ),
              ),
            ),
            Container(
              height: height * 0.10,
              child: Card(
                child: new TextFormField(
                  decoration: textDecoration("Enter your last name"),
                  initialValue: lname,
                  validator: TextVaildator.validateName,
                  onSaved: (String val) {
                    lname = val;
                  },
                ),
              ),
            ),
            Container(
              height: height * 0.10,
              child: Card(
                child: new TextFormField(
                  decoration: textDecoration("Enter your phone number"),
                  initialValue: phone,
                  validator: TextVaildator.validatePhone,
                  onSaved: (String val) {
                    phone = val;
                  },
                ),
              ),
            ),
            Container(
              height: height * 0.10,
              child: Card(
                child: new TextFormField(
                  decoration: textDecoration("Enter your address"),
                  initialValue: address,
                  validator: TextVaildator.validateString,
                  onSaved: (String val) {
                    address = val;
                  },
                ),
              ),
            ),
            Container(
              height: height * 0.12,
              child: GestureDetector(
                onTap: () {
                  onConfirm(context);
                },
                child: Card(
                  color: changeButtonColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Confirm",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //used to get height and width of current screen

    return Scaffold(
        appBar: AppBar(
          title: Text("Account Details"),
          backgroundColor: appBarColor,
        ),
        body: readOnlyView(context));
  }
}
