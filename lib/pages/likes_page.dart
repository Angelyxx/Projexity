import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projexity/pages/view_listing.dart';
import 'alt_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<DocumentSnapshot> likedListingsData = [];

  @override
  void initState() {
    super.initState();
    _fetchLikedListings();
  }

  Future<void> _fetchLikedListings() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userData = await userDoc.get();
    final likedListingIds =
        List<String>.from(userData.data()?['likedListings'] ?? []);

    // Fetch the liked listings data from the listings collection
    final likedListingsSnapshot = await FirebaseFirestore.instance
        .collection('listings')
        .where(
          FieldPath.documentId,
          whereIn: likedListingIds,
        )
        .get();
    setState(() {
      likedListingsData = likedListingsSnapshot.docs;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
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
          'Liked Listings',
          style: TextStyle(fontSize: 30.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: likedListingsData.length,
        itemBuilder: (context, index) {
          final data = likedListingsData[index].data() as Map<String, dynamic>?;

          final listingId = likedListingsData[index].id;

          final imageUrl = data != null && data.containsKey('imageUrl')
              ? data['imageUrl'] as String
              : null;

          final projectTitle = data != null && data.containsKey('projectTitle')
              ? data['projectTitle'] as String // Cast projectTitle to String
              : 'Project Title';

          final projectSubtitle =
              data != null && data.containsKey('projectSubtitle')
                  ? data['projectSubtitle']
                      as String // Cast projectSubtitle to String
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
                                  : AssetImage('assets/placeholder_image.png')
                                      as ImageProvider,
                              fit: BoxFit
                                  .contain, // Use BoxFit.contain to fit the entire image
                            ),
                          ),
                        )
                      : SizedBox(width: 150),
                  SizedBox(
                      width: 10), // Add some spacing between image and text
                  Expanded(
                    // Wrap the content with Expanded to fill the available space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Project Title
                        Text(
                          projectTitle,
                          style: GoogleFonts.bebasNeue(fontSize: 35),
                        ),
                        // Add some spacing between title and subtitle
                        SizedBox(height: 5),
                        // Project Subtitle
                        Text(
                          projectSubtitle,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              textStyle: TextStyle(color: Colors.blueGrey)),
                        ),
                      ],
                    ),
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
