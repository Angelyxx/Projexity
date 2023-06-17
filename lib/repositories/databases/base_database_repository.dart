import 'package:projexity/models/user_model.dart';

abstract class BaseDatabaseStorageRepository {
  Stream<User> getUser();
  Future<void> updateUserPicture(String imageName);
}
