import 'package:hookah1/Widgets/ShopCard.dart';

class ShopItem
{
  ShopItem(this.cardItem,this.quantity,this.price);
  ShopCard cardItem;
  int quantity;
  double price;
}

class OrderManager {

  String name;
  String address;
  String phone;
  String email;
  List<ShopItem> cartItems = new List<ShopItem>();
  
}
