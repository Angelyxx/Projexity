// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projexity/blocs/images/images_bloc.dart';
import 'package:projexity/blocs/onboarding/onboarding_bloc.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';

class PfpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      if (state is OnboardingLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is OnboardingLoaded) {
        var images = state.user.profileImageUrl;
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
                    Text('Upload your \n profile picture!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ))),
                    const SizedBox(height: 35),

                    Container(
                        height: 360,
                        width: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 3, color: Colors.white),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              ImagePicker _picker = ImagePicker();
                              final XFile? _image = await _picker.pickImage(
                                  source: ImageSource.gallery);

                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('No image was selected')));
                              }

                              if (_image != null) {
                                print('Uploading ...');
                                //StorageRepository().uploadImage(_image);
                                context
                                    .read<OnboardingBloc>()
                                    .add(UpdateUserImages(image: _image));
                              }
                            },
                          ),
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )));
      } else {
        return Text('Something went wrong');
      }
    });
  }
}
