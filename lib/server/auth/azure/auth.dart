import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/server/tools/makeRequest.dart';

autenticationAAD(config) async {
  final AadOAuth oAuth = AadOAuth(config);
  await oAuth.login();
  final accessIdToken = await oAuth.getIdToken();
  final accessToken = await oAuth.getAccessToken();
  if (accessIdToken != null) {
    final userAccount = await getADAccount(accessToken);
    final userPrincipalName = userAccount['userPrincipalName'];

    var results = await makeRequest('/users/authAD', 'POST', {
      "authtoken": accessIdToken
    }, {
      "email":
          userPrincipalName.substring(0, userPrincipalName.indexOf('#EXT#'))
    });
    Map<String, dynamic> response = json.decode(results!.body);
    return response;
  }
}

getADAccount(accessIdToken) async {
  final headers = {"Authorization": "Bearer $accessIdToken"};
  final results =
      await http.get(Uri.parse(dotenv.env['MS_GRAPH_URL']!), headers: headers);
  Map<String, dynamic> response = json.decode(results.body);
  return response;
}
