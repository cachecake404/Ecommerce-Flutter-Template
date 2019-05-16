import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  State<StatefulWidget> createState() {
      return _LoginState();
  }
}
class _LoginState extends State<Login>  {
  @override
  Widget build(BuildContext context) {
    
    //the text input handlers
    final textControllerUsername = TextEditingController();
    final textControllerPassword = TextEditingController();
    
    //used to get height and width of current screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //the top bar of the screen containing the logo and the title
    _hookahLogoAppBar(String title, String imageLink) => AppBar(
      backgroundColor: Theme.of(context).buttonColor,
      leading:  Image.asset(imageLink,
        alignment: Alignment.centerLeft, 
      ),
      title: Text("$title"),
    );

    //a styled general text field
    _inputTextField(String hintText, bool _obsecureText, TextEditingController output) => TextField(
      controller: output,
      decoration: InputDecoration(
        //fillColor: Theme.of(context).accentColor,
        hintText: "$hintText",
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color:Theme.of(context).accentColor,
            width: 2.5,
            ),
        borderRadius: BorderRadius.all(Radius.circular(40.0),),
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor,
          ),
        border: OutlineInputBorder(),
        ),
        obscureText: _obsecureText,
    ); 

    //the styled login button
    _loginButton() => ButtonTheme(
    minWidth: width*0.49,
    height: height*0.10,
    child: RaisedButton(
      onPressed: () {},
      color: Theme.of(context).accentColor,
      child: new Text(
        'Login',
        style: TextStyle(
        color: Theme.of(context).backgroundColor,
        fontSize: 30,
          ),
        ),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0))
      ),
    );

    //setup of the login box
    _insideLoginBox() => Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[     
                SizedBox(height: height * 0.03),
                _inputTextField("username", false, textControllerUsername),
                SizedBox(height: height * 0.03),
                _inputTextField("password", true, textControllerPassword),
                SizedBox(height: height * 0.03), 
                Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: <Widget>[
                 _loginButton(),
                ],
              )
            ]
          )
        )
      ],
    );

    //stlying of the login box
    _loginBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
      color: Colors.deepPurple,
    );

    return Scaffold(
        appBar: _hookahLogoAppBar("Hookah Express", "lib/Assets/hookah_express.png"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[ 
                  SizedBox(
                    width: width * 0.90,
                    height: height * 0.40,
                    child: DecoratedBox(
                      child: _insideLoginBox(),
                      decoration: _loginBoxDecoration(), 
                    ),
                  ),
                ]
                )
              ]
            ),
        );
    }
}
