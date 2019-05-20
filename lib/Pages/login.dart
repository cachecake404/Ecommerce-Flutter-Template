import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    //the text input handlers
    final textControllerUsername = TextEditingController();
    final textControllerPassword = TextEditingController();

    //used to get height and width of current screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Colors
    Color appBarColor = Theme.of(context).buttonColor;
    Color inputTextFieldColor = Theme.of(context).accentColor;
    Color hintStyleColor = Theme.of(context).accentColor;
    Color loginButtonColor = Theme.of(context).accentColor;
    Color loginButtonTextStyleColor = Theme.of(context).backgroundColor;
    Color loginBoxStyleColor = Color(0xFF510177);
    Color backgroundColor = Color(0xFF580182);
    // //the top bar of the screen containing the logo and the title
    // _hookahLogoAppBar(String title, String imageLink) => AppBar(
    //       backgroundColor: Theme.of(context).buttonColor,
    //       leading: Image.asset(
    //         imageLink,
    //         alignment: Alignment.centerLeft,
    //       ),
    //       title: Text("$title"),
    //     );

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
                color: inputTextFieldColor,
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
    _loginButton() => ButtonTheme(
          minWidth: width * 0.39,
          height: height * 0.08,
          child: RaisedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/shop");
              },
              color: loginButtonColor,
              child: new Text(
                'Login',
                style: TextStyle(
                  color: loginButtonTextStyleColor,
                  fontSize: 30,
                ),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );

    //setup of the login box
    _insideLoginBox() => Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: height * 0.03),
                      _inputTextField(
                          "username", false, textControllerUsername),
                      SizedBox(height: height * 0.03),
                      _inputTextField("password", true, textControllerPassword),
                      SizedBox(height: height * 0.03),
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
                          _loginButton(),
                        ],
                      )
                    ]))
          ],
        );

    //stlying of the login box
    _loginBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
          color: loginBoxStyleColor,
        );

    return Scaffold(
      appBar: _hookahLogoAppBar("Hookah Express"),
      body: Container(
        alignment: Alignment.topCenter,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "lib/Assets/hookah_express_old.png",
              height: height * 0.30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: width * 0.90,
                  height: height * 0.38,
                  child: DecoratedBox(
                    child: _insideLoginBox(),
                    decoration: _loginBoxDecoration(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
