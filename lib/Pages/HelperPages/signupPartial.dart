import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import "../../Tools/Auth.dart";
import "package:provider/provider.dart";
import "../../Tools/TextValidator.dart";
import "../../Tools/UserDataManager.dart";

class SignUpPartial extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SignUpPartialState();
  }
}

class _SignUpPartialState extends State<SignUpPartial> {
  //Variable for the form to function
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController pEdit = new TextEditingController();

  String _fname, _lname, _phoneNumber, _address;
  String errorString = "";

  // Set the Users Details in Database;
  void setUser(BuildContext context) async {
    Auth authHandler = new Auth();
    //Setting user to be used by provider globally
    var dataTracker = Provider.of<DataTracker>(context);
    //Adding custom user data
    FirebaseUser user = await authHandler.getCurrentUser();
    UserDataManager umanager = new UserDataManager(user);
    int ageDays = (DateTime.now().difference(timeNow).inDays);
    await umanager.postData({
      "first_name": _fname,
      "last_name": _lname,
      "age": ageDays ~/ 365,
      "phone": _phoneNumber,
      "address": _address
    });
    print("DONE POSTING DATA");
    dataTracker.auth = authHandler;
    print("DONE SETTING AUTH");
    await Provider.of<DataTracker>(context).autoSetData();
    print("DONE SETTING AUTO DATA");
    Provider.of<DataTracker>(context).isLoading = false;
    print("DONE CHANGING LOAD STATUS");
    //Change screen
    Provider.of<DataTracker>(context).needData = true;
    print("DONE SETTING NEED DATA");
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/shop', (Route<dynamic> route) => false);
  }

  // Function for picking date
  DateTime timeNow = DateTime.now();
  Future<void> selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: timeNow,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != timeNow) {
      setState(() {
        timeNow = picked;
      });
    }
  }

  //VALIDATION CHECKS
  bool _validate = false;

  // If legal returns true
  bool checkAge() {
    int dur = DateTime.now().difference(timeNow).inDays; // 6570 is 18 years old

    if (dur < 6570) {
      return false;
    } else {
      return true;
    }
  }
  // On sumbit function to execute

  void onSignUpClick(BuildContext context) {
    if (_key.currentState.validate()) {
      setState(() {
        errorString = "";
      });
      Provider.of<DataTracker>(context).isLoading = true;
      // No any error in validation
      _key.currentState.save();
      if (!checkAge()) {
        setState(() {
          errorString = "You need to be at least 18 years old to sign up";
        });
        Provider.of<DataTracker>(context).isLoading = false;
      } else {
        setState(() {
          errorString = "";
        });
        setUser(context);
      }
      //setUser(context);
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
    Color inputTextColor = Colors.white;

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
            decoration: _formFieldsDecoration("First Name"),
            validator: TextVaildator.validateName,
            onSaved: (String val) {
              _fname = val;
            },
          ),
          new SizedBox(height: height * 0.01),
          new TextFormField(
            style: new TextStyle(color: inputTextColor),
            decoration: _formFieldsDecoration("Last Name"),
            validator: TextVaildator.validateName,
            onSaved: (String val) {
              _lname = val;
            },
          ),
          new SizedBox(height: height * 0.03),
          new TextFormField(
              style: new TextStyle(color: inputTextColor),
              decoration: _formFieldsDecoration('phone'),
              keyboardType: TextInputType.phone,
              validator: TextVaildator.validatePhone,
              onSaved: (String val) {
                _phoneNumber = val;
              }),
          new SizedBox(height: height * 0.01),
          new TextFormField(
              style: new TextStyle(color: inputTextColor),
              decoration: _formFieldsDecoration('Address'),
              validator: TextVaildator.validateString,
              onSaved: (String val) {
                _address = val;
              }),
          new SizedBox(height: height * 0.01),
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
          new SizedBox(height: height * 0.01),
          Text(
            errorString,
            style:
                TextStyle(color: errorTextColor, fontWeight: FontWeight.w500),
          ),
          new ButtonTheme(
              minWidth: width * 0.49,
              height: height * 0.10,
              child: Provider.of<DataTracker>(context).loadingWidget(
                false,
                new RaisedButton(
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
              )),
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
