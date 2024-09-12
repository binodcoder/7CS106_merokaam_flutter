import 'dart:convert';

import '../entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel extends User {
  UserModel({
    int? id,
    required String email,
    required String password,
  }) : super(
          email: email,
          password: password,
        );

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
      );
}
