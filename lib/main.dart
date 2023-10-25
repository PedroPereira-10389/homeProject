import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/login.dart';
import 'package:shopping_list/utils/localStorage.dart';

Future<void> main() async {
  LocalStorage storage = LocalStorage();
  await dotenv.load();
  await storage.delete();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAD OAuth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      navigatorKey: navigatorKey,
    );
  }
}
