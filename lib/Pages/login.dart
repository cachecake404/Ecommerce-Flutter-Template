import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import "../Tools/Auth.dart";
import "package:provider/provider.dart";
import "../Tools/TextValidator.dart";

class Login extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  //Variables for form to function
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _username, _password;
  String validationText = "";

  // On Login Function
  void onSignInClick() async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("username $_username");
      print("password $_password");
      Auth authObj = new Auth();
      String message = await authObj.signIn(_username, _password);
      Provider.of<DataTracker>(context).auth = authObj;
      if (message == "") {
        Navigator.pushReplacementNamed(context, '/shop');
      } else {
        setState(() {
          validationText = message;
        });
      }
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //used to get height and width of current screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Colors
    Color appBarColor = Theme.of(context).buttonColor;
    Color hintStyleColor = Theme.of(context).accentColor;
    Color buttonsColor = Theme.of(context).accentColor;
    Color buttonTextColor = Theme.of(context).backgroundColor;
    Color signupBoxBgColor = Color(0xFF510177);
    Color backgroundColor = Color(0xFF580182);
    Color validationTextColor = Colors.redAccent;
    // UI COMPONENTS

    _hookahLogoAppBar(String title) => AppBar(
          backgroundColor: appBarColor,
          title: Text("$title"),
        );

    _singInBoxDecoration() => BoxDecoration(
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

    _signInBox() {
      return new Column(
        children: <Widget>[
          new TextFormField(
              decoration: _formFieldsDecoration('email'),
              validator: TextVaildator.validateEmail,
              onSaved: (String val) {
                _username = val;
              }),
          new SizedBox(height: height * 0.02),
          new TextFormField(
              decoration: _formFieldsDecoration('password'),
              obscureText: true,
              validator: TextVaildator.validatePassword,
              onSaved: (String val) {
                _password = val;
              }),
          Text(
            validationText,
            style: TextStyle(
                color: validationTextColor, fontWeight: FontWeight.w500),
          ),
          new SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Image.asset("lib/Assets/facebook_icon.png"),
                onPressed: () {},
              ),
              Spacer(),
              IconButton(
                icon: Image.asset("lib/Assets/google_icon.png"),
                onPressed: () {},
              ),
              Spacer(),
              Spacer(),
              new ButtonTheme(
                minWidth: width * 0.49,
                height: height * 0.10,
                child: new RaisedButton(
                  onPressed: onSignInClick,
                  color: buttonsColor,
                  child: new Text(
                    'Sign In',
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
          )
        ],
      );
    }

    return MaterialApp(
      home: new Scaffold(
        appBar: _hookahLogoAppBar("Hookah Express"),
        body: Container(
          color: backgroundColor,
          child: new ListView(
            children: <Widget>[
              Image.asset("lib/Assets/icon.ico", height: height * 0.4),
              new SingleChildScrollView(
                child: new Container(
                  decoration: _singInBoxDecoration(),
                  padding: EdgeInsets.all(15.0),
                  margin: new EdgeInsets.all(15.0),
                  child: new Form(
                    key: _key,
                    autovalidate: _validate,
                    child: _signInBox(),
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
