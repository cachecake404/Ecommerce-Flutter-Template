import "../Widgets/ShopCard.dart";
import "./HttpHandler.dart";
class ProductsHandler
{
    ProductsHandler();
    Future<void> postObject(String endpoint,Map<String,dynamic> data) async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", endpoint);
    Map<String, dynamic> response = await hand.addData(data);
    print(response);
    }

    Future<List<ShopCard>> getObject(String endpoint) async {
    HttpHandler hand = new HttpHandler(
        "https://studyfirebase-5b760.firebaseio.com/", endpoint);
    Map<String, dynamic> response = await hand.getData();
    List<ShopCard> shopCards = new List<ShopCard>();
    for(var obj in response.values)
    {
      shopCards.add(ShopCard(obj["name"],obj["shortDescrip"],obj["longDescrip"],obj["image"],double.parse(obj["price"].toString())));
    }
      return shopCards;
    }




}