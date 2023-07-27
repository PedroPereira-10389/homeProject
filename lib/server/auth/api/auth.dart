import 'package:shopping_list/server/tools/makeRequest.dart';

authenticationByUser(username, password) async {
  var result = await makeRequest(
      '/users/auth', 'POST', {}, {"username": username, "password": password});
  return result?.body;
}
