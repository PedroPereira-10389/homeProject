import 'dart:convert';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microsoft_graph_api/models/models.dart';
import 'package:shopping_list/server/tools/makeRequest.dart';
import 'package:shopping_list/utils/localStorage.dart';
import 'package:microsoft_graph_api/microsoft_graph_api.dart';

init(navigatorKey) async {
  final Config config = Config(
      tenant: dotenv.env['MS_AD_TENAND_ID']!,
      clientId: dotenv.env['MS_CLIENT_ID']!,
      scope: "openid profile offline_access",
      redirectUri:
          "msauth://${dotenv.env['MS_AD_PACKAGE_NAME']!}/${dotenv.env['MS_AD_SIGNATURE_HASH']!}",
      navigatorKey: navigatorKey,
      webUseRedirect: false,
      loader: const Center(child: CircularProgressIndicator()));
  return config;
}

autenticationAAD(navigatorKey) async {
  LocalStorage storage = LocalStorage();
  var config = await init(navigatorKey);
  final AadOAuth oAuth = AadOAuth(config);
  await oAuth.login();
  final accessIdToken = await oAuth.getIdToken();
  final accessToken = await oAuth.getAccessToken();
  if (accessIdToken != null) {
    storage.set("access_id_token", accessIdToken);
    storage.set("access_token", accessToken);
    final userAccount = await getADAccount(accessToken);
    final userPrincipalName = userAccount['userPrincipalName'];
    var results = await makeRequest('/users/authAD', 'POST', {
      "authtoken": accessIdToken
    }, {
      "email":
          userPrincipalName.substring(0, userPrincipalName.indexOf('#EXT#'))
    });
    Map<String, dynamic> response = json.decode(results!.body);
    if (response['statusCode'] == 403) {
      logoutAD(navigatorKey);
      autenticationAAD(navigatorKey);
    }

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

Future<Widget> getProfilePhotoURL() async {
  LocalStorage storage = LocalStorage();
  var token = await storage.get("access_token");
  if (token != null) {
    MSGraphAPI graphAPI = MSGraphAPI(token);
    ImageProvider image = await graphAPI.me
        .fetchUserProfileImage(PhotoSize().getPicSize(PhotoSizeEnum.size48x48));
    return Center(child:CircleAvatar(backgroundImage: image, radius: 20, ));
  }
  return Container();
}

convertADPhoto(url) async {
  var response = await http.get(
    Uri.parse(url),
  );
  return response.bodyBytes;
}

logoutAD(navigatorKey) async {
  var config = await init(navigatorKey);
  final AadOAuth oAuth = AadOAuth(config);
  await oAuth.logout();
  return true;
}
