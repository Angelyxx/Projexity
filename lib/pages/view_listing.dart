import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projexity/pages/chatting_screens/chat_page.dart';

class ViewListing extends StatefulWidget {
  final String listingId;

  const ViewListing({Key? key, required this.listingId}) : super(key: key);

  @override
  _ViewListingState createState() => _ViewListingState();
}

Future<String> getNameFromUID(String uid) async {
  final collection = FirebaseFirestore.instance.collection('users');
  final document = await collection.doc(uid).get();

  if (document.exists) {
    final data = document.data();
    final name = data?['name'];
    return name;
  } else {
    return '';
  }
}

class _ViewListingState extends State<ViewListing> {
  DocumentSnapshot? listingData;

  @override
  void initState() {
    super.initState();
    _fetchListingData();
  }

  Future<void> _fetchListingData() async {
    final listingSnapshot = await FirebaseFirestore.instance
        .collection('listings')
        .doc(widget.listingId)
        .get();
    setState(() {
      listingData = listingSnapshot;
    });
  }

  Widget _buildRoundedButton() {
    return Container(
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromRGBO(249, 200, 6, 1),
      ),
      child: const Center(
        child: Text(
          "Let's Chat!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listingData == null) {
      // Display a loading indicator or placeholder while data is being fetched
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 200, 6, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listingData!['projectTitle'],
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              listingData!['projectSubtitle'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Text(
              'Description:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              listingData!['projectDescription'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Text(
              'Recommended Skills:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              listingData!['recommendedSkills'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Text(
              'Number of Members:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              listingData!['numberOfMembers'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
            onTap: () async {
              final receiverID = listingData!["owner"];
              final user = FirebaseAuth.instance.currentUser!;
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({
                'matches': FieldValue.arrayUnion([listingData!["owner"]])
              });
              final uid = receiverID; // Replace with the actual UID
              final receiverName = await getNameFromUID(uid);
              print(receiverName);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUserName: receiverName,
                    receieverID: receiverID,
                  ),
                ),
              );
            },
            child: _buildRoundedButton()),
      ),
    );
  }
}
