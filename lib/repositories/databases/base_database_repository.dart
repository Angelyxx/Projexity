import 'package:projexity/models/user_model.dart';

abstract class BaseDatabaseStorageRepository {
  Stream<User> getUser(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> updateUserPicture(User user, String imageName);
}
