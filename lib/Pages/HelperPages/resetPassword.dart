//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:hookah1/Tools/DataTracker.dart';
import "../../Tools/Auth.dart";
//import "package:provider/provider.dart";
import "../../Tools/TextValidator.dart";

class ResetPass extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _RestPassState();
  }
}

class _RestPassState extends State<ResetPass> {
  //Variable for the form to function
  GlobalKey<FormState> _key = new GlobalKey();

  String _email;
  String errorString = "";
  String buttonText = "Reset";
  //VALIDATION CHECKS
  bool _validate = false;
  //Send Once Check
  bool sendOnce = false;
  // On sumbit function to execute

  void onResetClick(BuildContext context) {
    if (_key.currentState.validate()) {
      setState(() {
        errorString = "";
      });
      //Provider.of<DataTracker>(context).isLoading = true;
      _key.currentState.save();
      _email = _email.trim();
      Auth authObj = new Auth();
      authObj.resetPassword(_email);
      if (sendOnce) {
        setState(() {
          errorString = "Reset Email Sent Again!";
        });
      }

      if (!sendOnce) {
        setState(() {
          errorString = "Email Sent Check Your Email For Instructions";
          buttonText = "Resend Reset";
          sendOnce = true;
        });
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  //Building widget

  @override
  Widget build(BuildContext context) {
    //used to get height and width of current screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Colors
    Color appBarColor = Theme.of(context).buttonColor;
    Color buttonsColor = Theme.of(context).accentColor;
    Color hintStyleColor = Theme.of(context).accentColor;
    Color buttonTextColor = Theme.of(context).backgroundColor;
    Color signupBoxBgColor = Color(0xFF510177);
    Color backgroundColor = Color(0xFF580182);
    Color inputTextColor = Colors.white;
    Color errorTextColor = Colors.redAccent;

    // UI COMPONENTS

    _hookahLogoAppBar(String title) => AppBar(
          backgroundColor: appBarColor,
          title: Text("$title"),
        );

    _singUpBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
          color: signupBoxBgColor,
        );

    _formFieldsDecoration(String hintText) => new InputDecoration(
          fillColor: Theme.of(context).accentColor,
          hintText: "$hintText",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          hintStyle: TextStyle(
            color: hintStyleColor,
          ),
          border: OutlineInputBorder(),
        );

    _signUpBox() {
      return new Column(
        children: <Widget>[
          new TextFormField(
            style: new TextStyle(color: inputTextColor),
            decoration: _formFieldsDecoration("Enter Email For Password Reset"),
            validator: TextVaildator.validateEmail,
            onSaved: (String val) {
              _email = val;
            },
          ),
          new SizedBox(height: height * 0.03),
          Text(
            errorString,
            style:
                TextStyle(color: errorTextColor, fontWeight: FontWeight.w500),
          ),
          new SizedBox(height: height * 0.02),
          new ButtonTheme(
            minWidth: width * 0.49,
            height: height * 0.10,
            child: new RaisedButton(
              onPressed: () {
                onResetClick(context);
              },
              color: buttonsColor,
              child: new Text(
                buttonText,
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 30,
                ),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40.0)),
            ),
          ),
        ],
      );
    }

    //Build Page
    return MaterialApp(
      home: new Scaffold(
        appBar: _hookahLogoAppBar("Hookah Express"),
        body: Container(
          color: backgroundColor,
          child: new ListView(
            children: <Widget>[
              Image.asset("lib/Assets/icon.ico", height: height * 0.1),
              new SingleChildScrollView(
                child: new Container(
                  decoration: _singUpBoxDecoration(),
                  padding: EdgeInsets.all(15.0),
                  margin: new EdgeInsets.all(15.0),
                  child: new Form(
                    key: _key,
                    autovalidate: _validate,
                    child: _signUpBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
