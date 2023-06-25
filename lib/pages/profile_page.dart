// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [buildTop(), buildContent(), buildAbout()],
    ));
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
      Text('AHHH',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
      const SizedBox(height: 8),
      Text(
        'Your mum',
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
      const SizedBox(height: 8),
    ]);

Widget buildAbout() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bio',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 8),
        Text('I aspire to be a software engineer',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 18,
            )),
        const SizedBox(height: 8),
        Text('Interests',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 11),
        Text('- Java  \n -Python',
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
