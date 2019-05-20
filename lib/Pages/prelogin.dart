import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Prelogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //used to get height and width of current screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    //Colors
    Color buttonColors = Theme.of(context).accentColor;
    Color lineBetweenButtons = Theme.of(context).accentColor;
    Color bgColor = Theme.of(context).buttonColor;
    Color bottomButtonsColor = Colors.deepPurple;

    //the two buttons at the bottom of the screen
    _bottomButtons(String buttonText, String path) => ButtonTheme(
          minWidth: width * 0.49,
          height: height * 0.10,
          child: RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, path);
            },
            color: bottomButtonsColor,
            child: new Text(
              '$buttonText',
              style: TextStyle(
                color: buttonColors,
                fontSize: 30,
              ),
            ),
          ),
        );

    //the line above the two buttons
    _topDivider() => Container(
          height: width * 0.004,
          width: width,
          color: lineBetweenButtons,
        );

    //the line between the two buttons
    _verticalDivider() => Container(
          height: height * 0.10,
          width: width * 0.009,
          color: lineBetweenButtons,
        );

    return Scaffold(
        backgroundColor: bgColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              "lib/Assets/hookah_express.png",
              alignment: Alignment.center,
              height: height * 0.77,
              width: width * 0.9,
            ),
            Column(children: <Widget>[
              _topDivider(),
              Row(
                children: <Widget>[
                  _bottomButtons("Sign In", "/login"),
                  _verticalDivider(),
                  _bottomButtons("Sign Up", "/signup"),
                ],
              )
            ])
          ],
        ));
  }
}
