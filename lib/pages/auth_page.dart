import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projexity/pages/login_page.dart';
import 'package:projexity/pages/onboarding_screen.dart';
import 'package:projexity/pages/start_page.dart';
import 'alt_page.dart';
import 'home_page.dart';

/// This class checks for the authentication state of our app

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  /// Constructor for the widget
  /// @return HomePage()
  /// @return LoginPage()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return OnBoardingScreen(); //if the user exist, return home page
            } else {
              return LoginPage(
                showRegisterPage: () {},
              );
            }
          }),
    );
  }
}
