import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/server/tools/makeRequest.dart';
import 'package:shopping_list/utils/localStorage.dart';
import 'package:http/http.dart' as http;

getProducts() async {
  LocalStorage storage = LocalStorage();
  var serverToken = await storage.get('access_id_token');
  var foodToken = await getProductsToken();

  var headers = {
    "Authorization": "Bearer $serverToken",
    "x-api-key": "$foodToken"
  };

  var results = await makeRequest('/products', 'GET', headers, {});
  print(results?.body);
}

getProductsToken() async {
  LocalStorage storage = LocalStorage();
  var foodToken = await storage.get('food_access_token');
  
    var headers = {
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization":
          "Basic ${base64Encode(utf8.encode('${dotenv.env['FOOD_API_CLIENT_ID']}:${dotenv.env['FOOD_API_CLIENT_SECRET']}'))}"
    };
    var body = {'grant_type': 'client_credentials', 'scope': 'basic'};
    var results = await http.post(
      Uri.parse(dotenv.env['FOOD_API_AUTH_URL']!),
      headers: headers,
      body: body,
    );
    Map<String, dynamic> responseData = json.decode(results.body);
    print(responseData);
    storage.set('food_access_token', responseData['access_token']);
    return responseData['access_token'];


 
}
