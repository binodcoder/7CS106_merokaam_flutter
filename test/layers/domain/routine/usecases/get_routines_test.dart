import 'package:fitness_app/core/model/routine_model.dart';
import 'package:fitness_app/core/usecases/usecase.dart';
import 'package:fitness_app/layers/domain/routine/repositories/routine_repositories.dart';
import 'package:fitness_app/layers/domain/routine/usecases/get_routines.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockRoutineRepository extends Mock implements RoutineRepository {}

void main() {
  late GetRoutines usecase;
  late MockRoutineRepository mockRoutineRepository;
  setUp(() {
    mockRoutineRepository = MockRoutineRepository();
    usecase = GetRoutines(mockRoutineRepository);
  });

  List<RoutineModel> tRoutine = [
    RoutineModel(
      id: 1,
      description: '',
      difficulty: '',
      duration: 0,
      name: '',
      source: '',
    )
  ];
  test(
    'should get all blog post from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When readPost is called with any argument, always answer with
      // the Right "side" of Either containing a test Post object.
      when(mockRoutineRepository.getRoutines()).thenAnswer((_) async => Right(tRoutine));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(NoParams());
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tRoutine));
      // Verify that the method has been called on the Repository
      verify(mockRoutineRepository.getRoutines());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRoutineRepository);
    },
  );
}
