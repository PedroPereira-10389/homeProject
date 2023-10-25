import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/login.dart';
import 'package:shopping_list/main.dart';
import 'package:shopping_list/server/auth/api/auth.dart';
import 'package:shopping_list/server/auth/azure/auth.dart';
import 'package:shopping_list/utils/localStorage.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool goBack;
  final bool showIcons;
  const Header({
    super.key,
    required this.goBack,
    required this.showIcons,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Shopping List'),
      automaticallyImplyLeading: goBack,
      actions: showIcons
          ? <Widget>[
              FutureBuilder<Widget>(
                  future: getProfilePhotoURL(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data as Widget;
                    }
                    return const CircularProgressIndicator();
                  }),
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  signout(context);
                },
              ),
            ]
          : null,
    );
  }

  void signout(context) async {
    LocalStorage storage = LocalStorage();
    var isAd = await storage.get("isAD");
    var canSignout = isAd ? await logoutAD(navigatorKey) : await logout();
    if (canSignout) {
      storage.delete();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
