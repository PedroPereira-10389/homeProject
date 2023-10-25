import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  get(itemName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(itemName);
  }

  set(itemName, item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (item.runtimeType) {
      case bool:
        await prefs.setBool(itemName, item);
        break;
      case String:
        await prefs.setString(itemName, item);
        break;
      case int:
        await prefs.setInt(itemName, item);
        break;
      case double:
        await prefs.setDouble(itemName, item);
        break;
      default:
    }
  }

  delete() async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.clear();
  }
}
