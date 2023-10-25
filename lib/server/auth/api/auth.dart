import 'dart:convert';

import 'package:shopping_list/server/tools/makeRequest.dart';

authenticationByUser(String username, String password) async {
  Map<String, String> headers = {};
  var results = await makeRequest('/users/auth', 'POST', headers,
      {"username": username, "password": password});
   Map<String, dynamic> response = json.decode(results!.body);
  return response;
}

logout() async {
  return true;
}
