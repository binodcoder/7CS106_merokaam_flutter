import 'dart:convert';

import '../entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel extends User {
  UserModel({
    int? id,
    required String email,
    required String name,
    int? phone,
    required String password,
    String? role,
    DateTime? createdAt,
  }) : super(
          id: id,
          email: email,
          name: name,
          phone: phone,
          password: password,
          role: role,
          createdAt: createdAt,
        );

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        role: json["role"],
        createdAt: json["createdAt"],
      );
}
