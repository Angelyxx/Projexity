// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projexity/components/login_button.dart';
import 'package:projexity/components/square_tile.dart';
import 'package:projexity/services/auth_service.dart';
import 'package:projexity/pages/forgot_pw_page.dart';
import 'package:projexity/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {    
    
    try {
      //trying signing in
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
     
     if (user != null) {
      // User exists in the database, proceed to sign in
      Navigator.pop(context); // Pop the loading indicator dialog
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // User does not exist in the database
      print('No user found');
    }
    } on FirebaseAuthException catch (e) {
    // Show the error message to the user
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sign In Error'),
          content: Text(e.message.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bckground = const Color.fromARGB(255, 223, 220, 220);
    Color inputBox = const Color(0xFFA0A9B1);
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
                      'Welcome back and let\'s get to work!',
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

                    //password
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
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    //Sign in Button
                    /*
                    LoginButton(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        await signIn();
                        Navigator.pop(context); // Pop the loading indicator dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExplorePage()),
                        );
                      },
                    ),
                    */
                    // Sign in Button
                    LoginButton(
                      onTap: () async {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Missing Information'),
                                content: Text('Please enter both email and password.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          try {
                            await signIn();
                            Navigator.pop(context); // Pop the loading indicator dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExplorePage()),
                            );
                          } catch (error) {
                            Navigator.pop(context); // Pop the loading indicator dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Sign In Error'),
                                  content: Text('An error occurred. Please try again later.'),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context); // Close the dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
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
                        Text('Not a member?'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text(
                            'Register now',
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
