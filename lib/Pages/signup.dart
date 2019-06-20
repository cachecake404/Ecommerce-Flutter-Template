import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import "../Tools/Auth.dart";
import "package:provider/provider.dart";
import "../Tools/TextValidator.dart";

class SignUp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  //Variable for the form to function
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController pEdit = new TextEditingController();

  String _fname,
      _lname,
      _email,
      _phoneNumber,
      _address,
      _password,
      _confirmPassword;
  String errorString = "";

  // Function to set user on signup

  void setUser(BuildContext context) async {
    Auth authHandler = new Auth();
    String message = await authHandler.signUp(_email, _password);
    if (message == "") {
      print("No errors !");
      var dataTracker = Provider.of<DataTracker>(context);
      dataTracker.auth = authHandler;
      Navigator.pushReplacementNamed(context, '/shop');
    } else {
      setState(() {
        errorString = message;
      });
    }
  }

  // Function for picking date
  DateTime timeNow = DateTime.now();
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

  //VALIDATION CHECKS
  bool _validate = false;

  // Custom Validation
  String validateConfirmPassword(String value) {
    String pass = pEdit.text;
    if (value.length == 0) {
      return "Confirm Password is Required";
    }

    if (value.toString() != pass.toString()) {
      return "Passwords do not match";
    }

    int dur = DateTime.now().difference(timeNow).inDays; // 6570 is 18 years old

    if (dur < 6570) {
      return "You need to be 18 years old to sign up!";
    }
    return null;
  }

  // On sumbit function to execute

  void onSignUpClick(BuildContext context) {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("First Name $_fname");
      print("Last Name $_lname");
      print("Email $_email");
      print("Mobile $_phoneNumber");
      print("Address $_address");
      print("Day is " +
          timeNow.day.toString() +
          " Month is " +
          timeNow.month.toString() +
          " Year is " +
          timeNow.year.toString());
      print("password $_password");
      print("confirm password $_confirmPassword");
      setUser(context);
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  //Building widget

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('MM-dd-yyyy').format(timeNow); // String form of time;

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
    Color dobTextColor = Colors.white;
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
            // decoration: new InputDecoration(hintText: 'Name'),
            decoration: _formFieldsDecoration("First Name"),
            validator: TextVaildator.validateName,
            onSaved: (String val) {
              _fname = val;
            },
          ),
          new SizedBox(height: height * 0.01),
          new TextFormField(
            // decoration: new InputDecoration(hintText: 'Name'),
            decoration: _formFieldsDecoration("Last Name"),
            validator: TextVaildator.validateName,
            onSaved: (String val) {
              _lname = val;
            },
          ),
          new SizedBox(height: height * 0.03),
          new TextFormField(
              decoration: _formFieldsDecoration('email'),
              keyboardType: TextInputType.emailAddress,
              validator: TextVaildator.validateEmail,
              onSaved: (String val) {
                _email = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('phone'),
              keyboardType: TextInputType.phone,
              validator: TextVaildator.validatePhone,
              onSaved: (String val) {
                _phoneNumber = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              decoration: _formFieldsDecoration('Address'),
              validator: TextVaildator.validateString,
              onSaved: (String val) {
                _address = val;
              }),
          new SizedBox(height: height * 0.03),
          new Row(
            children: <Widget>[
              Text(
                "  Date of Birth: ",
                style:
                    TextStyle(color: dobTextColor, fontWeight: FontWeight.w800),
              ),
              Text(
                formattedDate,
                style:
                    TextStyle(color: dobTextColor, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              RaisedButton(
                onPressed: () {
                  selectedDate(context);
                },
                child: Text("Select"),
              )
            ],
          ),
          new SizedBox(height: height * 0.03),
          new TextFormField(
              controller: pEdit,
              decoration: _formFieldsDecoration('password'),
              obscureText: true,
              validator: TextVaildator.validatePassword,
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
          Text(
            errorString,
            style:
                TextStyle(color: errorTextColor, fontWeight: FontWeight.w500),
          ),
          new ButtonTheme(
            minWidth: width * 0.49,
            height: height * 0.10,
            child: new RaisedButton(
              onPressed: () {
                onSignUpClick(context);
              },
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
}
