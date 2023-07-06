import 'package:projexity/models/user_model.dart';

abstract class BaseDatabaseStorageRepository {
  //Future<Stream<User>> getUser(String userId);
  Stream<User> getUser(String userId);
  Stream<User> getUserStreamFromFirestore(String userId);
  Future<User> getUserFromFirestore(String userId);
  User getUserStreamRhys(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> updateUserPicture(User user, String imageName);
}
