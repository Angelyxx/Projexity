import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Listing extends StatefulWidget {
  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  // Define text field controllers for the input fields
  TextEditingController _projectTitleController = TextEditingController();
  TextEditingController _projectSubtitleController = TextEditingController();
  TextEditingController _projectDescriptionController = TextEditingController();
  TextEditingController _recommendedSkillsController = TextEditingController();
  TextEditingController _numberOfMembersController = TextEditingController();
  File? imageFile;

  @override
  void dispose() {
    // Dispose the text field controllers when the widget is disposed
    _projectTitleController.dispose();
    _projectSubtitleController.dispose();
    _projectDescriptionController.dispose();
    _recommendedSkillsController.dispose();
    _numberOfMembersController.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle the error
      print('Image selection error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 200, 6, 1),
        elevation: 0.0,
        title: const Text(
          'Tell us more about your project!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
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
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: _selectImage,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: imageFile != null
                      ? Image.file(imageFile!, fit: BoxFit.cover)
                      : Icon(Icons.add_photo_alternate,
                          size: 50.0, color: Colors.grey),
                ),
              ),
              SizedBox(height: 30.0),
              _buildCategoryTitle('Project Title'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(
                  _projectTitleController), // Add text field controllers here
              SizedBox(height: 30.0),
              _buildCategoryTitle('Project Subtitle'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(
                  _projectSubtitleController), // Add text field controllers here
              SizedBox(height: 30.0),
              _buildCategoryTitle('Project Description'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(
                  _projectDescriptionController), // Add text field controllers here
              SizedBox(height: 30.0),
              _buildCategoryTitle('Recommended Skills'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(
                  _recommendedSkillsController), // Add text field controllers here
              SizedBox(height: 30.0),
              _buildCategoryTitle('Number of Members'),
              SizedBox(height: 10.0),
              _buildRoundedContainer(
                  _numberOfMembersController), // Add text field controllers here
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
            child: _buildRoundedButton()),
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

  Widget _buildRoundedContainer(TextEditingController controller) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
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

  void _showProjectListedDialog(BuildContext context) async {
    // Get the values from the text fields
    String projectTitle = _projectTitleController.text;
    String projectSubtitle = _projectSubtitleController.text;
    String projectDescription = _projectDescriptionController.text;
    String recommendedSkills = _recommendedSkillsController.text;
    String numberOfMembers = _numberOfMembersController.text;

    // Upload image to Firebase Storage
    String? imageUrl;
    if (imageFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('listing_images/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile!);
      imageUrl = await storageRef.getDownloadURL();
    }

    // Store the data in Firestore
    FirebaseFirestore.instance.collection('listings').add({
      'owner': FirebaseAuth.instance.currentUser!.uid,
      'projectTitle': projectTitle,
      'projectSubtitle': projectSubtitle,
      'projectDescription': projectDescription,
      'recommendedSkills': recommendedSkills,
      'numberOfMembers': numberOfMembers,
      'imageUrl': imageUrl,
    }).then((_) {
      // Show the success dialog
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
                  // Clear the text field controllers
                  _projectTitleController.clear();
                  _projectSubtitleController.clear();
                  _projectDescriptionController.clear();
                  _recommendedSkillsController.clear();
                  _numberOfMembersController.clear();
                },
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Show an error dialog if the listing couldn't be added
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to list the project.'),
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
    });
  }
}
