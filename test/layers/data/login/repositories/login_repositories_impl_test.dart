import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/layers/data/login/datasources/login_remote_data_source.dart';
import 'package:merokaam/layers/data/login/repositories/login_repositories_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../job_profile/repositories/job_profile_repositories_impl_test.mocks.dart';
import 'login_repositories_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockLoginRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  group('login', () {
    final tLoginModel = LoginModel(email: 'test', password: 'password');
    final tUserInfoResponse = UserInfoResponse(
      id: 1,
      jwtToken: '',
      username: '',
      userTypeName: '',
    );

    test('should return UserInfoResponse when the call to remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.login(any)).thenAnswer((_) async => tUserInfoResponse);

      // Act
      final result = await repository.login(tLoginModel);

      // Assert
      verify(mockRemoteDataSource.login(tLoginModel));
      expect(result, Right(tUserInfoResponse));
    });

    test('should return CacheFailure when CacheException is thrown', () async {
      // Arrange
      when(mockRemoteDataSource.login(any)).thenThrow(CacheException());

      // Act
      final result = await repository.login(tLoginModel);

      // Assert
      verify(mockRemoteDataSource.login(tLoginModel));
      expect(result, Left(CacheFailure()));
    });

    test('should return LoginFailure when LoginException is thrown', () async {
      // Arrange
      when(mockRemoteDataSource.login(any)).thenThrow(LoginException());

      // Act
      final result = await repository.login(tLoginModel);

      // Assert
      verify(mockRemoteDataSource.login(tLoginModel));
      expect(result, Left(LoginFailure()));
    });
  });
}
