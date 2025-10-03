import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? phoneNumber;

  const User({
    required this.uid,
    required this.email,
    this.displayName,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [uid, email, displayName, phoneNumber];
}
