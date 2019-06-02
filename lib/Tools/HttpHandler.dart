import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHandler {
  String url = "";
  String endpoint ="";
  HttpHandler(String link,String endp) {
    url = link;
    endpoint = endp;
  }
  Future<Map<String, dynamic>> addData(Map<String, dynamic> dataToBeSend) async {
    http.Response response = await http.post(
        url+endpoint+".json",
        body: json.encode(dataToBeSend),headers: {"Content-Type":"application/json"});

    Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  
  }

  Future<Map<String, dynamic>> getData() async {
    final http.Response response = await http
        .get(url+endpoint+".json");

    Map<String, dynamic> responseData = json.decode(response.body);

    return responseData;
  }
}
