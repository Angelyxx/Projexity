// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projexity/pages/alt_page.dart';
import 'package:projexity/pages/login_page.dart';
import 'package:projexity/pages/auth_page.dart';
import 'package:projexity/pages/onboarding_screen.dart';
import 'package:uuid/uuid.dart';

import '../blocs/onboarding/onboarding_bloc.dart';
import '../models/user_model.dart';

/// This class is the implementation of our starting page

class StartPage extends StatelessWidget {
  const StartPage({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(249, 200, 6, 1),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 75),
            //logo
            Image.asset(
              'lib/images/banner.png',
              //height: 90,
            ),
            //const SizedBox(height: 15),
            Image.asset(
              'lib/images/icon.png',
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 75),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AuthPage(), // OnBoardingScreen()),
                    ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(90, 105, 120, 1),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(200, 60),
                ),
              ),
              child: const Text(
                "Let's get started!",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
