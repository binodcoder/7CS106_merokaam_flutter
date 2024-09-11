import 'package:http/http.dart' as http;
import '../../../../core/entities/login.dart';
import '../../../../core/entities/user_info_response.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserInfoResponse> login(LoginModel loginModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  Future<UserInfoResponse> _login(String url, LoginModel loginModel) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: loginModelToJson(loginModel),
    );
    if (response.statusCode == 200) {
      return userInfoResponseFromJson(response.body);
    } else {
      throw LoginException();
    }
  }

  @override
  Future<UserInfoResponse> login(LoginModel loginModel) => _login("http://192.168.1.180:5000/api/auth/signin", loginModel);
}
