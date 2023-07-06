import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:projexity/repositories/databases/base_database_repository.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';

import '../../models/user_model.dart';

class DatabaseRepository extends BaseDatabaseStorageRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    print("Getting user");
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<User> getUserFromFirestore(String userId) async {
    print("getUserFromFirestore");
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    User user = User.fromSnapshot(snapshot);
    return user;
  }

  @override
  Stream<User> getUserStreamFromFirestore(String userId) {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    print("getUserStreamFromFirestore");
    print('tried ' + userId);
    return userRef
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      User user = User.fromSnapshot(snapshot);
      return user;
    });
  }

  @override
  User getUserStreamRhys(String userId) {
    User user = User(
        id: userId,
        name: '',
        age: 0,
        profileImageUrl: '',
        interests: [],
        skills: []);
    FirebaseFirestore.instance.collection('users').doc(userId).get().then(
      (querySnapshot) {
        print("Successfully completed");

        //print("name " + querySnapshot.get('id'));
        print("getting " + querySnapshot.get('age').toString());
        print("getting " + querySnapshot.get('profileImageUrl'));
        print("getting  " + querySnapshot.get('name'));

        user = User(
            id: userId,
            age: querySnapshot.get('age'),
            name: querySnapshot.get('name'),
            profileImageUrl: querySnapshot.get('profileImageUrl'),
            interests: [],
            skills: []);

        //_firebaseFirestore.collection('users').doc(user.id).set(user.toMap());

        // for (var docSnapshot in querySnapshot.) {
        //   print('${docSnapshot.id} => ${docSnapshot.data()}');
        // }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return user;
    //throw ' is just a test~!';

    //throw 'hehe it died';
  }
  // @override
  // Future<Stream<User>> getUser(String userId) async {
  //   print("Getting user");
  //   CollectionReference userCollection =
  //       FirebaseFirestore.instance.collection('users');
  //   var doc = await userCollection.doc('testing').get();
  //   if (doc.exists) {
  //     print('it exists');
  //   } else {
  //     print('it does not');
  //   }
  //   return _firebaseFirestore
  //       .collection('users')
  //       .doc('testing')
  //       .snapshots()
  //       .map((snap) => User.fromSnapshot(snap));
  // }

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
