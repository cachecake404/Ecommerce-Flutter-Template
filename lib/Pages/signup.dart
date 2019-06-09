import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import "../Tools/Auth.dart";
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController pEdit = new TextEditingController();
  bool _validate = false;
  String _fname,
      _lname,
      _email,
      _phoneNumber,
      _address,
      _username,
      _password,
      _confirmPassword;
  FirebaseUser user;
   
  DateTime timeNow = DateTime.now();
  
  void setUser() async
  {
    Auth authHandler = new Auth();
    FirebaseUser us = await authHandler.signUp(_email, _password);
    setState(() {
     user = us; 
    });
    print(us.providerData);
  }

  Future<void> selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: timeNow,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != timeNow) {
      setState(() {
        timeNow = picked;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('MM-dd-yyyy').format(timeNow); // String form of time;

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
    Color dobTextColor = Colors.white;

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
            decoration: _formFieldsDecoration("First Name"),
            validator: validateName,
            onSaved: (String val) {
              _fname = val;
            },
          ),
          new SizedBox(height: height * 0.01),
          new TextFormField(
            // decoration: new InputDecoration(hintText: 'Name'),
            decoration: _formFieldsDecoration("Last Name"),
            validator: validateName,
            onSaved: (String val) {
              _lname = val;
            },
          ),
          new SizedBox(height: height * 0.03),
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
              decoration: _formFieldsDecoration('Address'),
              validator: validateUsername,
              onSaved: (String val) {
                _address = val;
              }),
          new SizedBox(height: height * 0.03),
          new Row(
            children: <Widget>[
              Text("  Date of Birth: ",style: TextStyle(color: dobTextColor,fontWeight: FontWeight.w800),),
              Text(formattedDate ,style: TextStyle(color: dobTextColor,fontWeight: FontWeight.w500),),
              Spacer(),
              RaisedButton(
                onPressed: () {selectedDate(context);},
                child: Text("Select"),
              )
            ],
          ),
          new SizedBox(height: height * 0.03),
          new TextFormField(
              decoration: _formFieldsDecoration('username'),
              validator: validateUsername,
              onSaved: (String val) {
                _username = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              controller: pEdit,
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
    String pass = pEdit.text;
    if (value.length == 0) {
      return "Confirm Password is Required";
    }
    
    if (value.toString() != pass.toString()) {
      return "Passwords do not match";
    }

    int dur = DateTime.now().difference(timeNow).inDays; // 6570 is 18 years old
    
    if(dur < 6570)
    {
      return "You need to be 18 years old to sign up!";
    }
    return null;
  }

  _onSignUpClick() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("First Name $_fname");
      print("Last Name $_lname");
      print("Email $_email");
      print("Mobile $_phoneNumber");
      print("Address $_address");
      print("Day is "+timeNow.day.toString()+" Month is "+timeNow.month.toString()+" Year is "+timeNow.year.toString());
      print("username $_username");
      print("password $_password");
      print("confirm password $_confirmPassword");
      //setUser();
     
      Navigator.pushReplacementNamed(context, '/shop');
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
