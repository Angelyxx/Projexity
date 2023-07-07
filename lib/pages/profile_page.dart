// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projexity/blocs/profile/profile_bloc.dart';
import 'package:projexity/pages/login_page.dart';

import '../blocs/auth/auth_bloc.dart';
import '../repositories/auth_repository.dart';
// Future<void> _signOut() async {
//     await FirebaseAuth.instance.signOut();
//     // Navigate to the start page or any other page you desire after sign-out
//     // You can use Navigator.pushReplacement to navigate to a new screen and replace the current screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => AltPage()),
//     );
//   }

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state);

          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? LoginPage(
                  showRegisterPage: () {},
                )
              : ProfilePage();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return Center(
          child: CircularProgressIndicator(),
          //hello
        );
      }

      if (state is ProfileLoaded) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                //cover image
                Container(
                    margin: EdgeInsets.only(bottom: 80),
                    child: Container(
                      color: Colors.grey,
                      child: Image.asset(
                        'lib/images/Placeholder-bckgrd.jpg',
                        width: double.infinity,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    )),
                //profile image
                Positioned(
                  top: 180, //cover height - profile height
                  child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage(state.user.profileImageUrl)),
                )
              ],
            ),
            Column(children: [
              const SizedBox(height: 8),
              Text(state.user.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8),
              Text(
                'Member',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 8),
            ]),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Interests',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    Text('- Java ',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        )),
                    const SizedBox(height: 30),
                    Text('Skills',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 11),
                    Text(' - Python',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        )),
                  ],
                )),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                RepositoryProvider.of<AuthRepository>(context).signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                            showRegisterPage: () {},
                          )),
                );
              },
              child: Center(
                child: Text(
                  'Sign Out',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        );
      } else {
        return Text("Something went wrong");
      }
    }));
  }
}

Widget buildTop() {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(margin: EdgeInsets.only(bottom: 80), child: buildCoverImage()),
      Positioned(
          top: 180, //cover height - profile height
          child: buildProfileImage())
    ],
  );
}

Widget buildContent() => Column(children: [
      const SizedBox(height: 8),
      Text('Bob',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
      const SizedBox(height: 8),
      Text(
        'Member',
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
      const SizedBox(height: 8),
    ]);

Widget buildAbout() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Interests',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 8),
        Text('- Java ',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 18,
            )),
        const SizedBox(height: 30),
        Text('Skills',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 11),
        Text(' - Python',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 18,
            )),
      ],
    ));

Widget buildInterests() => Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [Text("hello"), Text("help")],
      ),
    );

// Widget buildCoverImage() => Container(
//       color: Colors.grey,
//       child: Image.asset(
//         'lib/images/Placeholder-bckgrd.jpg',
//         width: double.infinity,
//         height: 260,
//         fit: BoxFit.cover,
//       ),
//     );

Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.asset(
        'lib/images/Placeholder-bckgrd.jpg',
        width: double.infinity,
        height: 260,
        fit: BoxFit.cover,
      ),
    );

Widget buildProfileImage() => CircleAvatar(
    radius: 80,
    backgroundColor: Colors.grey,
    backgroundImage: NetworkImage(
        'https://www.gpb.org/sites/default/files/styles/flexheight/public/npr_story_images/2021/03/24/gettyimages-1164815276-090e56f786505ce7e28df24b35b374a40f174275.jpg?itok=yqCgeVf2'));
