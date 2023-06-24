import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewListing extends StatefulWidget {
  final String listingId;

  const ViewListing({Key? key, required this.listingId}) : super(key: key);

  @override
  _ViewListingState createState() => _ViewListingState();
}

class _ViewListingState extends State<ViewListing> {
  DocumentSnapshot? listingData;

  @override
  void initState() {
    super.initState();
    _fetchListingData();
  }

  Future<void> _fetchListingData() async {
    final listingSnapshot =
        await FirebaseFirestore.instance.collection('listings').doc(widget.listingId).get();
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
          onTap: () {
            //Handle Button Click Here
          },
          child: _buildRoundedButton()
          ),
      ),
    );
  }
}