import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../Widgets/OrderCardHolder.dart";
import "package:provider/provider.dart";
import "../Tools/DataTracker.dart";
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import "../Tools/StripeManager.dart";
import 'package:stripe_payment/stripe_payment.dart';
import "./PostCart/Finished.dart";
import "./PostCart/Fail.dart";

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  //Colors
  Color appBarColor = Colors.deepPurpleAccent;
  Color orderCardsContainer = Colors.grey[200];
  Color priceInfoColor = Colors.deepPurple[50];
  Color checkOutColor = Colors.deepPurple;
  Color timePickColor = Colors.white;
  // Create Widget To Hold Price Info
  Widget priceContainer;
  Widget cardContainer = new Card(
    child: Center(
      child: Text("Loading"),
    ),
  );
  double itemPriceTotal;
  double taxRate;
  String checkOutText = "Checkout";

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // Widget to Store Delivery Time
  DateTime deliveryTime = DateTime.now();
  void renderPrice(BuildContext context) {
    setState(() {
      priceContainer = genPrice(context);
    });
  }

  void manageCheckout(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot dataTemp =
        await Firestore.instance.collection("cards").document(user.uid).get();
    dataTemp.data["currentChargeStatus"] = "Process";
    await Firestore.instance
        .collection("cards")
        .document(user.uid)
        .setData(dataTemp.data);
    String custID = dataTemp.data["custId"];
    if (custID == "new") {
      StripeSource.setPublishableKey(
          "pk_test_NhFl8ur8dyhyzAwlyeLkcnwj00MahF9SdK");
      await StripeSource.addSource().then((token) {
        StripeManager.addCard(user.uid, token);
        setState(() {
          checkOutText = "Proceed";
        });
      });
      Provider.of<DataTracker>(context).isLoading = true;
      await Future.delayed(const Duration(seconds: 8));
      await genCardUI(context);
    }

    double totalPrice = (itemPriceTotal + taxRate);
    Provider.of<DataTracker>(context).isLoading = true;
    StripeManager.chargeCustomer(user.uid, custID, totalPrice);
    await Future.delayed(const Duration(seconds: 8));
    DocumentSnapshot newTemp =
        await Firestore.instance.collection("cards").document(user.uid).get();
    bool errorCharge = await StripeManager.chargeError(user.uid);
    print(errorCharge);
    print(newTemp.data["currentChargeStatus"].toString());
    if ((!errorCharge) &&
        (newTemp.data["currentChargeStatus"].toString() == "Good")) {
      List<Map<String, dynamic>> itemJson = new List<Map<String, dynamic>>();
      for (var i in Provider.of<DataTracker>(context).shopItems.toList()) {
        itemJson.add(i.getJson());
      }
      await Firestore.instance
          .collection("cards")
          .document(user.uid)
          .collection("orders")
          .document(newTemp.data["currentCharge"])
          .setData({
        "date": DateTime.now().toString(),
        "items": itemJson,
        "price": totalPrice
      });
      Provider.of<DataTracker>(context).setOrderData();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Finished(
              (newTemp.data["currentCharge"]),
            ),
          ));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Fail(),
        ),
      );
    }
    Provider.of<DataTracker>(context).isLoading = false;
  }

  Future<void> genCardUI(BuildContext context) async {
    //Provider.of<DataTracker>(context).isLoading = true;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot dataTemp =
        await Firestore.instance.collection("cards").document(user.uid).get();
    String custID = dataTemp.data["custId"];
    String finger = dataTemp.data["currentFinger"];
    if (custID == "new") {
      setState(() {
        cardContainer = GestureDetector(
          onTap: () {
            manageEditCard(context);
          },
          child: Card(
            child: Row(
              children: <Widget>[
                Icon(Icons.credit_card),
                Spacer(),
                Icon(Icons.add)
              ],
            ),
          ),
        );
      });
    } else if (custID == "ERROR") {
      setState(() {
        cardContainer = GestureDetector(
          onTap: () {
            manageEditCard(context);
          },
          child: Card(
            child: Row(
              children: <Widget>[
                Icon(Icons.credit_card),
                Spacer(),
                Text("INVALID CARD"),
                Spacer(),
                Icon(Icons.add)
              ],
            ),
          ),
        );
      });
    } else {
      DocumentSnapshot dataVal = await Firestore.instance
          .collection("cards")
          .document(user.uid)
          .collection("sources")
          .document(finger)
          .get();
      String lastDigits = dataVal.data["card"]["last4"];
      String brand = dataVal.data["card"]["brand"];
      setState(() {
        cardContainer = GestureDetector(
          onTap: () {
            manageEditCard(context);
          },
          child: Card(
            child: Row(
              children: <Widget>[
                Icon(Icons.credit_card),
                Text(brand),
                Text("            **** **** **** " + lastDigits),
                Spacer(),
                Icon(Icons.edit)
              ],
            ),
          ),
        );
      });
    }
    //Provider.of<DataTracker>(context).isLoading = false;
  }

  void manageEditCard(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    StripeSource.setPublishableKey(
        "pk_test_NhFl8ur8dyhyzAwlyeLkcnwj00MahF9SdK");
    await StripeSource.addSource().then((token) {
      StripeManager.addCard(user.uid, token);
    });
    Provider.of<DataTracker>(context).isLoading = true;
    await Future.delayed(const Duration(seconds: 8));
    await genCardUI(context);
    Provider.of<DataTracker>(context).isLoading = false;
  }

  String clockText() {
    if (deliveryTime == DateTime.now()) {
      return "Now";
    } else {
      return DateFormat("MM-dd-yyyy\nhh:mm a").format(deliveryTime);
    }
  }

  Widget genPrice(BuildContext context) {
    itemPriceTotal = 0;
    for (var i in Provider.of<DataTracker>(context).shopItems) {
      itemPriceTotal += (i.price);
    }
    taxRate = itemPriceTotal * 0.0625;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.10,
      child: Card(
        color: priceInfoColor,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Items Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(r'$' + itemPriceTotal.toString())
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Tax: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(r'$' + taxRate.toString())
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Grand Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(r'$' + (itemPriceTotal + taxRate).toString())
              ],
            )
          ],
        ),
      ),
    );
  }

  void setTime() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      if (DateTime.now().compareTo(date) > 0) {
        date = DateTime.now();
      }
      setState(() {
        deliveryTime = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Widget cartItemsGen(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (Provider.of<DataTracker>(context).shopItems.length == 0) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.shopping_cart),
                Text("  Cart Empty  ")
              ],
            )
          ],
        ),
      );
    } else {
      return ListView(
        children: <Widget>[
          Container(
            height: height * 0.40,
            child: OrderCardHolder(context, renderPrice),
            color: orderCardsContainer,
          ),
          Container(
            height: height * 0.14,
          ),
          priceContainer,
          Container(
            height: height * 0.08,
            child: GestureDetector(
              onTap: () {
                setTime();
              },
              child: Card(
                color: timePickColor,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Text(clockText()),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.08,
            child: cardContainer,
          ),
          Provider.of<DataTracker>(context).loadingWidget(
              false,
              GestureDetector(
                onTap: () {
                  manageCheckout(context);
                },
                child: Container(
                  height: height * 0.08,
                  child: Card(
                    color: checkOutColor,
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Text(
                          checkOutText,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    genCardUI(context);
  }

  @override
  Widget build(BuildContext context) {
    priceContainer = genPrice(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: appBarColor,
      ),
      body: cartItemsGen(context),
    );
  }
}
