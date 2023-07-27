import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/components/body.dart';
import 'package:shopping_list/components/button.dart';
import 'package:shopping_list/components/form.dart';
import 'package:shopping_list/components/header.dart';
import 'package:shopping_list/components/inputs.dart';
import 'package:shopping_list/main.dart';
import 'package:shopping_list/utils/helpers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header(),
        body: Body(content: [
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 264,
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: 4,
              itemBuilder: (ctx, i) {
                return Card(
                  child: Column(children: [
                    Container(
                      child: Text('My List'),
                    ),
                    Container(
                      child: Text('My List'),
                    )
                  ]),
                );
              })
        ]));
  }
}
