import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    //the text input handlers
    final textControllerUsername = TextEditingController();
    final textControllerPassword = TextEditingController();
    final textControllerEmail = TextEditingController();
    final textControllerName = TextEditingController();
    final textControllerPhone = TextEditingController();

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
    
    //the top bar of the screen containing the logo and the title
    _hookahLogoAppBar(String title) => AppBar(
          backgroundColor: appBarColor,
          // leading: Image.asset(
          //   imageLink,
          //   alignment: Alignment.centerLeft,
          // ),
          title: Text("$title"),
        );

    //a styled general text field
    _inputTextField(String hintText, bool _obsecureText,
            TextEditingController output) =>
        TextField(
          controller: output,
          decoration: InputDecoration(
            //fillColor: Theme.of(context).accentColor,
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
          ),
          obscureText: _obsecureText,
        );

    //the styled login button
    _singUpButton() => ButtonTheme(
          minWidth: width * 0.49,
          height: height * 0.10,
          child: RaisedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/shop');
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
                  borderRadius: new BorderRadius.circular(40.0))),
        );

    //setup of the login box
    _insideSignUpBox() => Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: height * 0.03),
                      _inputTextField("name", false, textControllerName),
                      SizedBox(height: height * 0.03),
                      _inputTextField("email", false, textControllerEmail),
                      SizedBox(height: height * 0.03),
                      _inputTextField("phone", false, textControllerPhone),
                      SizedBox(height: height * 0.03),
                      _inputTextField(
                          "username", false, textControllerUsername),
                      SizedBox(height: height * 0.03),
                      _inputTextField("password", true, textControllerPassword),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _singUpButton(),
                        ],
                      )
                    ]))
          ],
        );

    //stlying of the login box
    _singUpBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
          color: signupBoxBgColor,
        );

    return Scaffold(
      appBar: _hookahLogoAppBar("Hookah Express"),
      body: Container(
        decoration: new BoxDecoration(color: backgroundColor),
        child: ListView(
            children: <Widget>[
              Image.asset("lib/Assets/icon.ico",height: height*0.1),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.90,
                      height: height * 0.78,
                      child: DecoratedBox(
                        child: _insideSignUpBox(),
                        decoration: _singUpBoxDecoration(),
                      ),
                    ),
                  ])
            ]),
      ),
    );
  }
}
