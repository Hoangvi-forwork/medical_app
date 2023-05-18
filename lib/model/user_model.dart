// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String password;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [uid, username, email, password];
}
