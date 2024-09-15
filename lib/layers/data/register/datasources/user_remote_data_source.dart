import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<int> addUser(UserModel userModel);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  Future<int> _addUser(String url, UserModel userModel) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userModel.toMap()),
    );
    if (response.statusCode == 200) {
      return 1;
    } else if (response.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> addUser(UserModel userModel) => _addUser("http://192.168.1.180:5000/api/auth/signup", userModel);
}
