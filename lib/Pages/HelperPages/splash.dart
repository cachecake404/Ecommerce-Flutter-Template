import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import '../../Tools/ProductsHandler.dart';
import "package:provider/provider.dart";

class Splash extends StatefulWidget {
  //Data to post
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final ProductsHandler manager = new ProductsHandler();

  final String endpoint = "products/type3";

  final Map<String, dynamic> data = {
    "name": "Freddy Teddy",
    "shortDescrip": "Blah Blah Blah\nBlah Blah Blah\nBlah Blah Blah",
    "longDescrip":
        "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah!",
    "image":
        "http://nerdist.com/wp-content/uploads/2018/02/Five-Nights-At-Freddys2-02122018-500x500.jpg",
    "price": 21
  };

  bool firstLoad = true;
  
  // Sample Function To Update Data
  // void updateSample(BuildContext context) {
  //   // Get current data to change and update
  //   DataTracker dataManager = Provider.of<DataTracker>(context);
  //   UserDataManager userHandler = new UserDataManager(dataManager.user);
  //   Map<String, dynamic> updatedData = dataManager.customData;
  //   // Data to update
  //   updatedData["first_name"] = "Sam";
  //   // Submit the update
  //   userHandler.updateData(updatedData, dataManager.customDataKey);
  //   dataManager.autoSetData();
  // }


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(context, '/prelogin'));
  }

  void callUpdates(BuildContext context) {
    if (firstLoad) {
      //Uncomment lower portion to actually post new data.
      //manager.postObject(endpoint, data);
      Provider.of<DataTracker>(context).setCards();
      firstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    callUpdates(context);

    return Scaffold(
      body: Container(
        child: Text("Loading)"),
      ),
    );
  }
}
