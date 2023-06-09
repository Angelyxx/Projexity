import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<auth.User?> signUp({
    required String email,
    required String password,
  });

  Future<void> signOut();
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password});
}
