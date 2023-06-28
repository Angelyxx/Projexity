import 'package:flutter/material.dart';
import 'package:projexity/pages/login_page.dart';
import 'package:projexity/pages/register_page.dart';

class AltPage extends StatefulWidget {
  const AltPage({super.key});

  @override
  State<AltPage> createState() => _AltPageState();
}

class _AltPageState extends State<AltPage> {
//initially shows the login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
