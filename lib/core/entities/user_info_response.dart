import 'dart:convert';

UserInfoResponse userInfoResponseFromJson(String str) => UserInfoResponse.fromJson(json.decode(str));

class UserInfoResponse {
  int id;
  String jwtToken;
  String username;
  String userTypeName;

  UserInfoResponse({
    required this.id,
    required this.jwtToken,
    required this.username,
    required this.userTypeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jwtToken': jwtToken,
      'username': username,
      'userTypeName': userTypeName,
    };
  }

  factory UserInfoResponse.fromJson(Map<String, dynamic> map) {
    return UserInfoResponse(
      id: map['id'] as int,
      jwtToken: map['jwtToken'] as String,
      username: map['username'] as String,
      userTypeName: map['userTypeName'] as String,
    );
  }
}
