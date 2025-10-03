import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(credential.user!);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();
      final updatedUser = _firebaseAuth.currentUser;
      
      return UserModel.fromFirebaseUser(updatedUser!);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return UserModel.fromFirebaseUser(firebaseUser);
    }
    return null;
  }
}
