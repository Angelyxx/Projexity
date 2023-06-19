import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projexity/pages/view_listing.dart';
import 'alt_page.dart';
import 'create_listing.dart';
import 'package:google_fonts/google_fonts.dart';

/// This class is the implementation of our home page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<DocumentSnapshot> listingsData = [];

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    final listingsSnapshot =
        await FirebaseFirestore.instance.collection('listings').get();
    setState(() {
      listingsData = listingsSnapshot.docs;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to the start page or any other page you desire after sign-out
    // You can use Navigator.pushReplacement to navigate to a new screen and replace the current screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AltPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 200, 6, 1),
        title: Text(
          'Explore',
          style: TextStyle(fontSize: 30.0),
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle the create listing action
              // This should navigate to the create listing screen
              // You can use Navigator.push to navigate to a new screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Listing(),
                ),
              );
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle the search action
              // You can implement search functionality here
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle the back button press
              // Sign out the user and navigate to the start page or any other page
              _signOut();
            },
          ),
        ],
      ),
      ///List view to scroll downwards
      body: ListView.builder(
        itemCount: listingsData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(listingsData[index]['projectTitle'], style: GoogleFonts.bebasNeue(fontSize: 50)),
                subtitle: Text(listingsData[index]['projectSubtitle'], style: GoogleFonts.bebasNeue(fontSize: 35)),
                onTap: () {
                  String listingId = listingsData[index].id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewListing(listingId: listingId),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}