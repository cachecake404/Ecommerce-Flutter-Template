import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _name, _email, _phoneNumber, _username, _password, _confirmPassword;

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
            // decoration: new InputDecoration(hintText: 'Name'),
            decoration: _formFieldsDecoration("name"),
            validator: validateName,
            onSaved: (String val) {
              _name = val;
            },
          ),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('email'),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              onSaved: (String val) {
                _email = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('phone'),
              keyboardType: TextInputType.phone,
              validator: validatePhone,
              onSaved: (String val) {
                _phoneNumber = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('username'),
              validator: validateUsername,
              onSaved: (String val) {
                _username = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('password'),
              obscureText: true,
              validator: validatePassword,
              onSaved: (String val) {
                _password = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('confirm password'),
              obscureText: true,
              validator: validateConfirmPassword,
              onSaved: (String val) {
                _confirmPassword = val;
              }),
          new SizedBox(height: height * 0.01),
          new ButtonTheme(
            minWidth: width * 0.49,
            height: height * 0.10,
            child: new RaisedButton(
              onPressed: _onSignUpClick,
              color: buttonsColor,
              child: new Text(
                'Sign Up',
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

  //VALIDATION CHECKS

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z\s]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validatePhone(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validateUsername(String value) {
    if (value.length == 0) {
      return "Username is Required";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    // print("current password $_password");
    if (value.length == 0) {
      return "Confirm Password is Required";
      // } else if (value != _password) {
      //   return "Does not match with Password";
    }
    return null;
  }

  _onSignUpClick() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Name $_name");
      print("Email $_email");
      print("Mobile $_phoneNumber");
      print("username $_username");
      print("password $_password");
      print("confirm password $_confirmPassword");
      Navigator.pushReplacementNamed(context, '/shop');
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
