import 'package:flutter/material.dart';
import 'package:shopping_list/components/body.dart';
import 'package:shopping_list/components/header.dart';
import 'package:shopping_list/components/list.dart';
import 'package:shopping_list/server/auth/azure/auth.dart';
import 'package:shopping_list/server/products/api/products.dart';
import 'package:shopping_list/utils/localStorage.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);
  @override
  State<ShoppingList> createState() => _ShoppingList();
}

class _ShoppingList extends State<ShoppingList> {
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header(
          goBack: true,
          showIcons: true,
        ),
        body: Body(content: [ListWidget()]));
  }
}
