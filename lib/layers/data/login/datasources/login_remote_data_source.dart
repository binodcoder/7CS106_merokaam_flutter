import 'package:http/http.dart' as http;
import '../../../../core/entities/login.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login(LoginModel loginModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  Future<UserModel> _login(String url, LoginModel loginModel) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: loginModelToJson(
        loginModel,
      ),
    );
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      throw LoginException();
    }
  }

  @override
  Future<UserModel> login(LoginModel loginModel) => _login(" ", loginModel);
}
