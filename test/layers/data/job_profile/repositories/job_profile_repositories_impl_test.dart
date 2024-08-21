import 'package:dartz/dartz.dart';
import 'package:merokaam/core/network/network_info.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRoutinesLocalDataSource extends Mock implements RoutinesLocalDataSource {}

@GenerateMocks([NetworkInfo])
@GenerateMocks([
  RoutineRemoteDataSource
], customMocks: [
  MockSpec<RoutineRemoteDataSource>(as: #MockRoutinesRemoteDataSourceForTest, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late RoutineRepositoryImpl repository;
  late MockRoutinesRemoteDataSource mockRemoteDataSource;
  late MockRoutinesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRoutinesRemoteDataSource();
    mockLocalDataSource = MockRoutinesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RoutineRepositoryImpl(
      routineRemoteDataSource: mockRemoteDataSource,
      routineLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('getRoutines', () {
    final tRoutineModel = [
      RoutineModel(
        id: 37,
        name: 'string',
        description: 'This is for random',
        difficulty: 'easy',
        duration: 10,
        source: 'pre_loaded',
        exercises: [],
      )
    ];

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getRoutines();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getRoutines()).thenAnswer((_) async => tRoutineModel);
        //act
        final result = await repository.getRoutines();
        //assert
        verify(mockRemoteDataSource.getRoutines());
        expect(result, equals(Right(tRoutineModel)));
      });
      test('should cache the data locally when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getRoutines()).thenAnswer((_) async => tRoutineModel);
        //act
        await repository.getRoutines();
        //assert
        verify(mockRemoteDataSource.getRoutines());
        // verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test('should return serverfailure when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getRoutines()).thenThrow(ServerException());
        //act
        final result = await repository.getRoutines();
        //assert
        verify(mockRemoteDataSource.getRoutines());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
