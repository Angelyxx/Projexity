// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projexity/components/sign_up_button.dart';
import '../components/square_tile.dart';
import '../services/auth_service.dart';
import 'explore_page.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color bckground = const Color.fromARGB(255, 223, 220, 220);
  Color inputBox = const Color(0xFFA0A9B1);
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {

    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bckground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 75),
                    //logo
                    Image.asset(
                      'lib/images/logo_transparent.png',
                      height: 90,
                    ),

                    const SizedBox(height: 25),
                    //caption
                    Text('Projexity', style: GoogleFonts.bebasNeue(fontSize: 36)
                        //TextStyle(
                        //fontWeight: FontWeight.bold,
                        //fontSize: 17,
                        //),
                        ),
                    const SizedBox(height: 5),
                    Text(
                      'Register below with your details!',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 45),
                    //email
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: inputBox,
                          border: Border.all(color: inputBox),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    //Password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: inputBox,
                          border: Border.all(color: inputBox),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password: Minimum 6 characters',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //confirm password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: inputBox,
                          border: Border.all(color: inputBox),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _confirmpasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    //Sign Up Button
                    SignUpButton(
                      onTap: () {
                        signUp();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExplorePage()),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    //continue with
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: const Color.fromARGB(255, 170, 168, 168),
                          ),
                        ),
                        Text('Or continue with'),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: const Color.fromARGB(255, 170, 168, 168),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 30),
                    //google sign-in  option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                            onTap: () => AuthService().signInWithGoogle(),
                            imagePath: 'lib/images/google-logo.png')
                      ],
                    ),
                    const SizedBox(height: 30),
                    //not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('I am a member!'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text(
                            'Login now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
