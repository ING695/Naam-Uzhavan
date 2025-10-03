import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}
