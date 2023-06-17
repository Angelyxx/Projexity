import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:projexity/repositories/databases/database_repository.dart';
import 'base_storage_repository.dart';

class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage.ref('user_1/${image.path}').putFile(File(image.path)).then(
            (p0) => DatabaseRepository().updateUserPicture(image.name),
          );
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(String imageName) async {
    String downloadURL =
        await storage.ref('user_1/$imageName').getDownloadURL();
    return downloadURL;
  }
}
