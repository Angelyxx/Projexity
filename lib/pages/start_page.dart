import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projexity/pages/login_page.dart';
import 'package:projexity/pages/auth_page.dart';
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
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset('lib/images/projexity_name.png'),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 100),
                  Positioned(
                    top: 170,
                    child: Image.asset(
                      'lib/images/icon.png',
                      height: 350,
                      width: 350,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      User user = User(
                          id: const Uuid().v1(),
                          name: '',
                          age: 0,
                          profileImageUrl: '',
                          interests: [],
                          skills: []);
                      context.read<OnboardingBloc>().add(
                            StartOnboarding(
                              user: user,
                            ),
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthPage()),
                      );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
