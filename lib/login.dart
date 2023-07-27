import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Shopping List'),
        ),
        body: Body(content: [
          Form(
              child: FormWidget(
            inputs: [
              InputWidget(
                label: 'User Name',
                hint: 'Enter valid mail id as abc@gmail.com',
                controller: usernameController,
                isPassword: false,
              ),
              InputWidget(
                  isPassword: true,
                  label: 'Password',
                  hint: 'Enter your secure password',
                  controller: passwordController),
              ButtonWidget(
                function: () => authenticate(
                    usernameController.text, passwordController.text),
                text: 'Sign In',
                icon: Container(),
              ),
              ButtonWidget(
                function: () => authenticateWithMs(
                    usernameController.text, passwordController.text),
                text: 'Sign in with Microsoft Account',
                icon: const Icon(FluentIcons.store_microsoft_24_regular),
              )
            ],
          ))
        ]));
  }

  authenticateWithMs(email, password) async {
    final Config config = Config(
        tenant: dotenv.env['MS_AD_TENAND_ID']!,
        clientId: dotenv.env['MS_CLIENT_ID']!,
        scope: "openid profile offline_access",
        // redirectUri is Optional as a default is calculated based on app type/web location
        redirectUri:
            "msauth://${dotenv.env['MS_AD_PACKAGE_NAME']!}/${dotenv.env['MS_AD_SIGNATURE_HASH']!}",
        navigatorKey: navigatorKey,
        webUseRedirect:
            false, // default is false - on web only, forces a redirect flow instead of popup auth
        //Optional parameter: Centered CircularProgressIndicator while rendering web page in WebView
        loader: const Center(child: CircularProgressIndicator()));

    var response = await autenticationAAD(config);
    SpinnerWidget;
    switch (response['status']) {
      case 200:
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
    var response = authenticationByUser(username, password);
    switch (response['status']) {
      case 200:
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
}
