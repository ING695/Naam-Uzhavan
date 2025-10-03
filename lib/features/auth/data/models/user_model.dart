import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.email,
    super.displayName,
    super.phoneNumber,
  });

  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
