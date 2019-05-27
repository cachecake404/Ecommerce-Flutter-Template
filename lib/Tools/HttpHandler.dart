import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHandler {
  String url = "";
  HttpHandler(String link) {
    url = link;
  }
  Future<String> addData(Map<String, dynamic> dataToBeSend) async {
    http.Response response = await http.post(
        "https://studyfirebase-5b760.firebaseio.com/people.json",
        body: json.encode(dataToBeSend));

    Map<String, dynamic> responseData = json.decode(response.body);
    String key = responseData["name"];
    return key;
  }

  Future<Map<String, dynamic>> getData(String key) async {
    final http.Response response = await http
        .get("https://studyfirebase-5b760.firebaseio.com/people.json");

    Map<String, dynamic> responseData = json.decode(response.body);

    return responseData;
  }
}
