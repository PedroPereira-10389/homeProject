import 'package:flutter/material.dart';
import 'package:shopping_list/components/body.dart';
import 'package:shopping_list/components/header.dart';
import 'package:shopping_list/pages/shopping/shoppingList.dart';
import 'package:shopping_list/server/products/api/products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  List<AssetImage> cardsImages = [
    const AssetImage('assets/images/home.jpg'),
    const AssetImage('assets/images/home.jpg'),
    const AssetImage('assets/images/home.jpg'),
    const AssetImage('assets/images/home.jpg'),
  ];
  List<String> cardTitle = ['Shopping', 'Passwords', 'Calendar', 'Others'];
  List<Widget> screens = [
    const ShoppingList(),
    const ShoppingList(),
    const ShoppingList(),
    const ShoppingList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header(
          goBack: false,
          showIcons: true,
        ),
        body: Body(content: [
          Container(
              alignment: Alignment.center,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.9,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200,
                  ),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                        onTap: () => {goTo(screens[i])},
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: SizedBox(
                            width: 400,
                            height: 200,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(image: cardsImages[i]),
                                  Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(cardTitle[i]),
                                    ),
                                  )
                                ]),
                          ),
                        ));
                  }))
        ]));
  }

  void goTo(screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
