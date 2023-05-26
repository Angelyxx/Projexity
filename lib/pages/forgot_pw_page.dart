// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  Color bckground = const Color.fromARGB(255, 223, 220, 220);
  Color inputBox = const Color(0xFFA0A9B1);
  Color originCol = const Color.fromRGBO(249, 200, 6, 1);

  @override 
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
         showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('A password reset link has been sent to your email!'),
          );
        },
        );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: originCol,
        elevation: 0,
      ),  
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your Email and we will send you a password reset link.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
              ),
          ),

          SizedBox(height: 10),

          //email textfield
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  border: Border.all(color: originCol),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[700])),
                  ),
                ),
            ),
          ),
          
          SizedBox(height: 10),


          MaterialButton(
            onPressed: passwordReset,
            child: Text('Reset Password'),
            color: originCol,
          ),
        ],
      )
    );
  }
}