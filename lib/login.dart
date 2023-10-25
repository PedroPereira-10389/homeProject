import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/components/header.dart';
import 'package:shopping_list/components/spinner.dart';
import 'package:shopping_list/server/auth/api/auth.dart';
import 'package:shopping_list/server/auth/azure/auth.dart';
import 'package:shopping_list/components/body.dart';
import 'package:shopping_list/components/button.dart';
import 'package:shopping_list/components/form.dart';
import 'package:shopping_list/components/inputs.dart';
import 'package:shopping_list/components/toast.dart';
import 'package:shopping_list/main.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:shopping_list/utils/localStorage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = LocalStorage();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header(
          goBack: false,
          showIcons: false,
        ),
        body: Body(content: [
          Form(
              key: _formKey,
              child: FormWidget(
                inputs: [
                  InputWidget(
                    label: 'User Name',
                    hint: 'Enter user name',
                    controller: usernameController,
                    isPassword: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter user name';
                      }
                      return null;
                    },
                  ),
                  InputWidget(
                    isPassword: true,
                    label: 'Password',
                    hint: 'Enter your secure password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  ButtonWidget(
                    function: () => authenticate(
                        usernameController.text, passwordController.text),
                    text: 'Sign In',
                    icon: Container(),
                  ),
                  ButtonWidget(
                    function: () => authenticateWithMs(),
                    text: 'Sign in with Microsoft Account',
                    icon: const Icon(FluentIcons.store_microsoft_24_regular),
                  )
                ],
              ))
        ]));
  }

  authenticateWithMs() async {
    var response = await autenticationAAD(navigatorKey);
    const SpinnerWidget(isLoading: true);
    switch (response['status']) {
      case 200:
        storage.set("isAD", true);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
      default:
        messageToast(response['message'], response['status']);
    }
  }

  authenticate(username, password) async {
    if (_formKey.currentState!.validate()) {
      var response = await authenticationByUser(username, password);
      switch (response['status']) {
        case 200:
          storage.set("isAD", false);
          storage.set("access_id_token", response['message']['access_token']); 
          storage.set("access_token", response['message']['access_token']);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
          break;
        default:
          messageToast('Invalid credentials', response['message']['status']);
      }
    }
  }
}
