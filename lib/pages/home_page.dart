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
        ],
      ),

      ///List view to scroll downwards
      body: ListView.builder(
        itemCount: listingsData.length,
        itemBuilder: (context, index) {
          final data = listingsData[index].data() as Map<String, dynamic>?;

          final listingId = listingsData[index].id;
          final isLiked = isListingLiked(listingId);

          final imageUrl = data != null && data.containsKey('imageUrl')
              ? data['imageUrl'] as String
              : null;

          final projectTitle = data != null && data.containsKey('projectTitle')
              ? data['projectTitle'] as String // Cast projectTitle to String
              : 'Project Title';

          final projectSubtitle = data != null && data.containsKey('projectSubtitle')
              ? data['projectSubtitle'] as String // Cast projectSubtitle to String
              : 'Project Subtitle';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  imageUrl != null
                      ? Container(
                          width: 150,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageUrl != null
                                  ? NetworkImage(imageUrl)
                                  : AssetImage('assets/placeholder_image.png') as ImageProvider,
                              fit: BoxFit.contain, // Use BoxFit.contain to fit the entire image
                            ),
                          ),
                        )
                      : SizedBox(width: 150),
                  SizedBox(width: 20), // Add some spacing between image and text
                  Expanded( // Wrap the content with Expanded to fill the available space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Project Title
                        Text(
                          projectTitle,
                          style: GoogleFonts.bebasNeue(fontSize: 35),
                        ),
                        // Add some spacing between title and subtitle
                        SizedBox(height: 15),
                        // Project Subtitle
                        Text(
                          projectSubtitle,
                          style: GoogleFonts.bebasNeue(fontSize: 20, textStyle: TextStyle(color: Colors.blueGrey)),
                        ),
                      ],
                    ),
                  ),
                  // Like Icon
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      toggleLikeStatus(listingId);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
