// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/onboarding/onboarding_bloc.dart';

class InterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      if (state is OnboardingLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is OnboardingLoaded) {
        return Scaffold(
            backgroundColor: Color.fromARGB(255, 249, 200, 6),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    //sign up header
                    Text('Sign up',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 84, 91))),
                    const SizedBox(height: 45),

                    //question header
                    Text('What are your \n interests?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ))),
                    const SizedBox(height: 35),

                    //logo
                    Image.asset(
                      'lib/images/interest_onboard.png',
                      height: 225,
                    ),

                    const SizedBox(height: 55),

                    //dob
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Interests (add at least 2)',
                                hintStyle:
                                    TextStyle(color: Colors.blueGrey[600])),
                            onChanged: (value) {
                              context.read<OnboardingBloc>().add(UpdateUser(
                                  user:
                                      state.user.copyWith(interests: [value])));
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )));
      } else {
        return Text("Something went wrong");
      }
    });
  }
}
