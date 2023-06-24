import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projexity/repositories/databases/base_database_repository.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';

import '../../models/user_model.dart';

class DatabaseRepository extends BaseDatabaseStorageRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  // @override
  // Future<String> createUser(User user) async {
  //   String documentId = await _firebaseFirestore
  //       .collection('users')
  //       .add(user.toMap())
  //       .then((value) {
  //     print('User added, ID: ${value.id}');
  //     return value.id;
  //   });
  //   return documentId;
  // }
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
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  void cancel() {}
}
