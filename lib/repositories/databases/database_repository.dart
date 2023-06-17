import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projexity/repositories/databases/base_database_repository.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';

import '../../models/user_model.dart';

class DatabaseRepository extends BaseDatabaseStorageRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection('users')
        .doc('mVy6I8fFQDSlNlqZceXE')
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPicture(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(imageName);
    return _firebaseFirestore
        .collection('users')
        .doc('mVy6I8fFQDSlNlqZceXE')
        .update({'profileImageUrl': downloadUrl});
  }
}
