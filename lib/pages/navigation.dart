// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projexity/pages/chat_page.dart';
import 'package:projexity/pages/home_page.dart';
import 'package:projexity/pages/likes_page.dart';
import 'package:projexity/pages/profile_page.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final tabs = [HomePage(), ChatPage(), LikesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(249, 200, 6, 1),
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.rocket_launch),
              label: 'Home',
              backgroundColor: const Color.fromRGBO(249, 200, 6, 1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: 'Chat',
              backgroundColor: const Color.fromRGBO(249, 200, 6, 1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Likes',
              backgroundColor: const Color.fromRGBO(249, 200, 6, 1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'profile',
              backgroundColor: const Color.fromRGBO(249, 200, 6, 1))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
