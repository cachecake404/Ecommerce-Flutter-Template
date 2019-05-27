import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHandler {
  String url = "";
  HttpHandler(String link) {
    url = link;
  }
  Future<Map<String, dynamic>> addData(Map<String, dynamic> dataToBeSend) async {
    http.Response response = await http.post(
        url,
        body: json.encode(dataToBeSend),headers: {"Content-Type":"application/json"});

    Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  
  }

  Future<Map<String, dynamic>> getData(String key) async {
    final http.Response response = await http
        .get(url);

    Map<String, dynamic> responseData = json.decode(response.body);

    return responseData;
  }
}
