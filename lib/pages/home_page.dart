import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projexity/pages/view_listing.dart';
import 'alt_page.dart';
import 'create_listing.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<DocumentSnapshot> listingsData = [];
  List<String> likedListings = [];

  @override
  void initState() {
    super.initState();
    _fetchListings();
    _fetchLikedListings();
  }

  Future<void> _fetchListings() async {
    final listingsSnapshot =
        await FirebaseFirestore.instance.collection('listings').get();
    setState(() {
      listingsData = listingsSnapshot.docs;
    });
  }

  Future<void> _fetchLikedListings() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userData = await userDoc.get();
    final userLikes = userData.data()?['likedListings'];
    setState(() {
      likedListings = List<String>.from(userLikes ?? []);
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AltPage()),
    );
  }

  Future<void> toggleLikeStatus(String listingId) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    // Get the current liked listings array from the user document
    final userData = await userDocRef.get();
    List<String> likedListings =
        List<String>.from(userData.data()?['likedListings'] ?? []);

    // Check if the listing ID is already in the likedListings array
    if (likedListings.contains(listingId)) {
      // Remove the listing ID from the likedListings array
      likedListings.remove(listingId);
    } else {
      // Add the listing ID to the likedListings array
      likedListings.add(listingId);
    }

    // Update the user document with the updated likedListings array
    await userDocRef.update({'likedListings': likedListings});

    // Update the likedListings in the state
    _fetchLikedListings();
  }

  bool isListingLiked(String listingId) {
    return likedListings.contains(listingId);
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
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),

      ///List view to scroll downwards
      body: ListView.builder(
        itemCount: listingsData.length,
        itemBuilder: (context, index) {
          final listingId = listingsData[index].id;
          final isLiked = isListingLiked(listingId);
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
                title: Text(
                  listingsData[index]['projectTitle'],
                  style: GoogleFonts.bebasNeue(fontSize: 50),
                ),
                subtitle: Text(
                  listingsData[index]['projectSubtitle'],
                  style: GoogleFonts.bebasNeue(fontSize: 30),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    toggleLikeStatus(listingId);
                  },
                ),
                onTap: () {
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
