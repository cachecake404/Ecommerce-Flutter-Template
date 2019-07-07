import 'package:flutter/material.dart';
import "./SubPages/OrderSub.dart";
import "./SubPages/ProfileSub.dart";
import "./SubPages/ShopSub.dart";
import 'package:hookah1/Tools/DataTracker.dart';
import "package:provider/provider.dart";
import "../Widgets/Searcher.dart";
import "../Widgets/ShopCard.dart";

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
  Color backgroundColorScaffold = Colors.white;
  Color selectedBottomItemColor = Colors.greenAccent;
  // Get Cards for Search
  Map<String, ShopCard> getCardMap(BuildContext context) {
    List<List<ShopCard>> shopCards = Provider.of<DataTracker>(context).allCards;
    Map<String, ShopCard> cardsMap = new Map<String, ShopCard>();
    for (int i = 0; i < shopCards.length; i++) {
      for (int j = 0; j < shopCards[i].length; j++) {
        cardsMap[shopCards[i][j].name] = shopCards[i][j];
      }
    }
    return cardsMap;
  }

  void signOff(BuildContext context) {
    Provider.of<DataTracker>(context).auth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/prelogin', (Route<dynamic> route) => false);
  }

//Variables for Bottom Bar
  int _selectedIndex = 0;
  static const MaterialColor bottomBarColor = bottomBar;
  Widget currentWidgetView = ShopSub();
// Function for Bottom Bar
  void _onItemTapped(int index) {
    setState(() {
      if (index != 1) {
        _selectedIndex = index;
      }

      if (index == 0) {
        currentWidgetView = ShopSub();
      }
      if (index == 1) {
        showSearch(context: context, delegate: DataSearch(getCardMap(context)));
        //currentWidgetView = SearchSub();
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
                  "Options ",
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
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: () {signOff(context);},
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
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
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
        onTap: (val) {
          _onItemTapped(val);
        },
      ),
    );
  }
}
