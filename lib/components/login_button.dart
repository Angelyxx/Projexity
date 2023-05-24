// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color btnColor = Color(0xFF4C545B);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: btnColor, borderRadius: BorderRadius.circular(8)),
          child: const Center(
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )),
    );
  }
  // return Container(
  //   decoration: BoxDecoration(color: Colors.black),
  //   child: Center(
  //     child: Text(

  //     ),
  //   )
  // )
}
