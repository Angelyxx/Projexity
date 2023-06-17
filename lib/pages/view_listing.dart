import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewListing extends StatefulWidget {
  final String listingId;

  const ViewListing({Key? key, required this.listingId}) : super(key: key);

  @override
  _ViewListingState createState() => _ViewListingState();
}

class _ViewListingState extends State<ViewListing> {
  late DocumentSnapshot listingData;

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

  @override
  Widget build(BuildContext context) {
    if (!listingData.exists) {
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
              listingData['projectTitle'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              listingData['projectSubtitle'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              listingData['projectDescription'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Recommended Skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              listingData['recommendedSkills'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Number of Members:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              listingData['numberOfMembers'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
