import 'package:fitness_app/core/model/routine_model.dart';
import 'package:fitness_app/layers/domain/routine/repositories/routine_repositories.dart';
import 'package:fitness_app/layers/domain/routine/usecases/add_routine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockRoutineRepository extends Mock implements RoutineRepository {}

void main() {
  late AddRoutine usecase;
  late MockRoutineRepository mockRoutineRepository;
  setUp(() {
    mockRoutineRepository = MockRoutineRepository();
    usecase = AddRoutine(mockRoutineRepository);
  });

  int tResponse = 1;

  RoutineModel tRoutineModel = RoutineModel(
    id: 1,
    description: '',
    difficulty: '',
    duration: 0,
    name: '',
    source: '',
  );

  test(
    'should get int from the repository',
    () async {
      when(mockRoutineRepository.addRoutine(tRoutineModel)).thenAnswer((_) async => Right(tResponse));
      final result = await usecase(tRoutineModel);
      expect(result, Right(tResponse));
      verify(mockRoutineRepository.addRoutine(tRoutineModel));
      verifyNoMoreInteractions(mockRoutineRepository);
    },
  );
}
