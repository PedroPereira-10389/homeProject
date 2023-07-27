import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<http.Response>? makeRequest(route, method, headers, data) {
  var url =
      "${dotenv.env['API_BASE_URL']!}:${dotenv.env['API_DEFAULT_PORT']!}$route";
  switch (method) {
    case 'GET':
      return http.get(Uri.parse(url), headers: headers);
    case 'POST':
      return http.post(Uri.parse(url), body: data, headers: headers);
    case 'PUT':
      return http.put(Uri.parse(url), body: data, headers: headers);
    case 'DELETE':
      return http.delete(Uri.parse(url), body: data, headers: headers);
    default:
  }
  return null;
}