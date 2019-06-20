import 'package:flutter/material.dart';
import "Pages/signup.dart";
import 'Pages/shop.dart';
import 'Pages/login.dart';
import 'Pages/prelogin.dart';
import 'package:provider/provider.dart';
import 'Tools/DataTracker.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //Colors
    Color themeBackgroundColor = Colors.deepPurple;
    Color themeButtonColor = Color(0xff551a8b);
    Color themeAccentColor = Color(0xffc0c0c0);
    // Color themePrimaryColorLight = Color(0xffB/A55D3);

    return ChangeNotifierProvider(builder: (context)=> DataTracker(),child:MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Prelogin(),
        '/login': (context) => Login(),
        '/shop': (context) => Shop(),
        '/signup': (context) => SignUp(),
      },
      title: "Hookah Express",
      theme: ThemeData(
        backgroundColor: themeBackgroundColor,
        buttonColor: themeButtonColor,
        accentColor: themeAccentColor,
      ),
    ));
  }
}
