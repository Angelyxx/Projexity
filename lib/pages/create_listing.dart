import 'package:flutter/material.dart';

class Listing extends StatelessWidget {
  const Listing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 200, 6, 1),
        elevation: 0.0,
        title: const Text(
          'Tell us more about your project!',
          style: TextStyle(color: Colors.white, fontSize: 20.0,),
        ),
        centerTitle: true,
        leading: IconButton(
            alignment: Alignment.topLeft,
            iconSize: 30.0,
            icon: Icon(Icons.close),
            onPressed: () {
              // Handle the create listing action
              Navigator.pop(context); // Close the current screen
            },
          ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCategoryTitle('Project Banner'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(),
              SizedBox(height: 30.0),
              _buildCategoryTitle('Project Title'),
              SizedBox(height: 10.0),              
              _buildRoundedContainer(),
              SizedBox(height: 30.0),
              _buildCategoryTitle('Project Subtitle'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(),
              SizedBox(height: 30.0),
              _buildCategoryTitle('Project Description'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(),
              SizedBox(height: 30.0),
              _buildCategoryTitle('Recommended Skills'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(),
              SizedBox(height: 30.0),
              _buildCategoryTitle('Number of Members'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            //Handle Button Click Here
            _showProjectListedDialog(context);
          },
          child: _buildRoundedButton()
          ),
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildRoundedContainer() {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          hintText: 'Enter details....',
        ),
      ),
    );
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
          'List It!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }

  void _showProjectListedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Project Listed!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}