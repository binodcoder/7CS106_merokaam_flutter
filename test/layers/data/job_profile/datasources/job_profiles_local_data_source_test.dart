import 'dart:convert';
import 'package:fitness_app/core/db/db_helper.dart';
import 'package:fitness_app/core/errors/exceptions.dart';
import 'package:fitness_app/core/model/routine_model.dart';
import 'package:fitness_app/layers/data/routine/data_sources/routines_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'routines_local_data_source_test.mocks.dart';

@GenerateMocks([
  DatabaseHelper
], customMocks: [
  MockSpec<DatabaseHelper>(as: #MockDatabaseHelperForTest, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late RoutinesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = RoutinesLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('getLastRoutine', () {
    final tRoutineModel = RoutineModel.fromJson(json.decode(fixture('routine_cached.json')));
    // const tRoutineModel = null;
    test('should return routine from Local db when there is one in the cache', () async {
      //arrange
      when(await mockDatabaseHelper.getRoutines()).thenReturn([tRoutineModel]);
      //act
      final result = await dataSource.getLastRoutines();
      //assert
      verify(mockDatabaseHelper.getRoutines());
      expect(result, equals(tRoutineModel));
    });

    test('should throw a CacheException when there is not a cached value', () async {
      //arrange
      when(await mockDatabaseHelper.getRoutines()).thenReturn([tRoutineModel]);
      //act
      final call = dataSource.getLastRoutines;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheRoutineModel', () {
    final tRoutineModel = RoutineModel(
      id: 37,
      name: 'string',
      description: 'This is for random',
      difficulty: 'easy',
      duration: 10,
      source: 'pre_loaded',
    );
    test('should call local db to cache the data', () async {
      //act
      dataSource.cacheRoutine(tRoutineModel);
      //assert
      //final expectedJsonString = json.encode(tRoutineModel.toJson());
      verify(mockDatabaseHelper.insertRoutine(tRoutineModel));
    });
  });
}
