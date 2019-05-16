import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(title: 'Flutter Demo Home Page'),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff551a8b),
      body: Column(
        children: <Widget>[
          Image.asset("lib/Assets/hookah_express.png"),
          Card(
            child: Row(children: <Widget>[
              Text("username: "),
              TextFormField(
                keyboardType: TextInputType.text,
              ),
              ],
            ),
          ),  
        ]
      ),
    );
  }
}
