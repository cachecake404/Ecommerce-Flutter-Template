import 'package:flutter/material.dart';
import "./SubPages/OrderSub.dart";
import "./SubPages/ProfileSub.dart";
import "./SubPages/ShopSub.dart";
import "./SubPages/SearchSub.dart";

//import 'package:flutter/painting.dart';

class Shop extends StatefulWidget {
  State<StatefulWidget> createState() {
    return ShopState();
  }
}

class ShopState extends State<Shop> {
  // This widget is the root of your application.

  //Colors
  static const Color bottomBar = Colors.deepPurple;
  Color drawerTextColor = Colors.white;
  Color drawerColor = Colors.deepPurple;
  Color appBarColor = Colors.deepPurple;
  Color backgroundColorScaffold = Colors.grey;
  Color selectedBottomItemColor = Colors.greenAccent;

//Variables for Bottom Bar
  int _selectedIndex = 0;
  static const MaterialColor bottomBarColor = bottomBar;
  Widget currentWidgetView = ShopSub();
// Function for Bottom Bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        currentWidgetView = ShopSub();
      }
      if (index == 1) {
        currentWidgetView = SearchSub();
      }
      if (index == 2) {
        currentWidgetView = OrderSub();
      }
      if (index == 3) {
        currentWidgetView = ProfileSub();
      }
      print("Current Bottom Selected Item: " + _selectedIndex.toString());
    });
  }

  // Build Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorScaffold,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 10, left: 20),
              child: Row(children: [
                Text(
                  "OPTIONS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: drawerTextColor,
                  ),
                ),
              ]),
              color: drawerColor,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                //trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Hookah Express"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: currentWidgetView,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text('Shop'),
              backgroundColor: bottomBarColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              backgroundColor: bottomBarColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              title: Text('Orders'),
              backgroundColor: bottomBarColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
              backgroundColor: bottomBarColor),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedBottomItemColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
