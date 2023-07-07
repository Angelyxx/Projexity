import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:projexity/repositories/databases/base_database_repository.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';

import '../../models/user_model.dart';

class DatabaseRepository extends BaseDatabaseStorageRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<User> getUser(String userId) async {
    User user = User(
      id: userId,
      name: 'nope',
      age: 0,
      profileImageUrl: '',
      interests: [],
      skills: [],
    );

    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      print("Successfully completed");
      print("getting " + querySnapshot.get('age').toString());
      print("getting " + querySnapshot.get('profileImageUrl'));
      print("getting " + querySnapshot.get('name'));

      User loadUser = User(
        id: userId,
        age: querySnapshot.get('age'),
        name: querySnapshot.get('name'),
        profileImageUrl: querySnapshot.get('profileImageUrl'),
        interests: [],
        skills: [],
      );

      return loadUser;
    } catch (e) {
      print("Error completing: $e");
      throw e;
    }
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then((value) => print('User document updated.'));
  }

  @override
  Future<void> updateUserPicture(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadURL(user, imageName);

    return _firebaseFirestore.collection('users').doc(user.id).update({
      //'imageUrls': FieldValue.arrayUnion([downloadUrl])
      'profileImageUrl': downloadUrl
    });
  }

  void cancel() {}
}
