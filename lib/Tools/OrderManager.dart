import 'package:hookah1/Widgets/ShopCard.dart';

class ShopItem
{
  ShopItem(this.cardItem,this.quantity,this.price);
  ShopCard cardItem;
  int quantity;
  double price;
  Map<String,dynamic> getJson()
  {
    Map<String,dynamic> dataVal = new Map<String,dynamic>();
    dataVal.addAll({"quantity":quantity});
    dataVal.addAll(cardItem.getJson());
    return dataVal;
  }
}

class OrderManager {

  String name;
  String address;
  String phone;
  String email;
  List<ShopItem> cartItems = new List<ShopItem>();
  
}
