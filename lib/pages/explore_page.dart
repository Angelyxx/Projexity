import 'package:flutter/material.dart';
import 'package:projexity/pages/create_listing.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Dummy data for demonstration purposes
  List<String> listings = [
    'Listing 1',
    'Listing 2',
    'Listing 3',
    'Listing 4',
    'Listing 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 200, 6, 1),
        title: Text('Explore',
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
        ],
      ),

      ///List view to scroll downwards
      body: ListView.builder(
        itemCount: listings.length,
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
                title: Text(listings[index]),
                subtitle: Text("Subtitle of project here...."),
                onTap: () {
                  // Handle tapping on a listing item
                  // This should navigate to the details screen for the selected listing
                  // You can use Navigator.push to navigate to a new screen
                },
              ),
            ),
          );
        },
      ),
    );
  }
}