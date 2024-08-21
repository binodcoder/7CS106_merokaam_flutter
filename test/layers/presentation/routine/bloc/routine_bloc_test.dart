import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/errors/failures.dart';
import 'package:fitness_app/core/model/routine_model.dart';
import 'package:fitness_app/layers/domain/routine/usecases/add_routine.dart';
import 'package:fitness_app/layers/domain/routine/usecases/get_routines.dart';
import 'package:fitness_app/layers/presentation/routine/get_routines/bloc/routine_bloc.dart';
import 'package:fitness_app/layers/presentation/routine/get_routines/bloc/routine_event.dart';
import 'package:fitness_app/layers/presentation/routine/get_routines/bloc/routine_state.dart';
import 'package:fitness_app/resources/strings_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'routine_bloc_test.mocks.dart';

@GenerateMocks([GetRoutines])
@GenerateMocks([AddRoutine])
void main() {
  late RoutineBloc bloc;
  late MockGetRoutines mockGetRoutines;
  late MockDeleteRoutine mockDeleteRoutine;

  setUp(() {
    mockGetRoutines = MockGetRoutines();
    mockDeleteRoutine = MockDeleteRoutine(1);

    bloc = RoutineBloc(getRoutines: mockGetRoutines, deleteRoutine: mockDeleteRoutine);
  });

  test('initialState should be RoutineInitialState', () async {
    //assert
    expect(bloc.initialState, equals(RoutineInitialState()));
  });

  group('GetRoutines', () {
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

    test('should get data from the routine usecase', () async* {
      //arrange

      when(mockGetRoutines(any)).thenAnswer((_) async => Right(tRoutineModel));
      //act
      bloc.add(RoutineInitialEvent());
      await untilCalled(mockGetRoutines(any));

      //assert
      verify(mockGetRoutines(any));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange

      when(mockGetRoutines(any)).thenAnswer((_) async => Right(tRoutineModel));

      //assert later
      final expected = [RoutineInitialState(), RoutineLoadingState(), RoutineLoadedSuccessState(tRoutineModel)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(RoutineInitialEvent());
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange

      when(mockGetRoutines(any)).thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expected = [RoutineInitialState(), RoutineLoadingState(), const RoutineErrorState(message: AppStrings.serverFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(RoutineInitialEvent());
    });

    test('should emits [Loading, Error] with a proper message for the error when getting data fails', () async* {
      //arrange

      when(mockGetRoutines(any)).thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expected = [RoutineInitialState(), RoutineLoadingState(), const RoutineErrorState(message: AppStrings.cacheFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(RoutineInitialEvent());
    });
  });

  group('DeleteRoutine', () {
    final tRoutineModel = RoutineModel(
      id: 37,
      name: 'string',
      description: 'This is for random',
      difficulty: 'easy',
      duration: 10,
      source: 'pre_loaded',
      exercises: [],
    );

    test('should get int from the delete usecase', () async* {
      //arrange
      when(mockDeleteRoutine(tRoutineModel.id!)).thenAnswer((_) async => const Right(1));
      //act
      bloc.add(RoutineDeleteButtonClickedEvent(tRoutineModel));
      await untilCalled(mockDeleteRoutine(1));

      //assert
      verify(mockDeleteRoutine(tRoutineModel.id!));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange
      when(mockDeleteRoutine(tRoutineModel.id!)).thenAnswer((_) async => const Right(1));

      //assert later
      final expected = [
        RoutineInitialState(),
        RoutineLoadingState(),
        RoutineLoadedSuccessState([tRoutineModel])
      ];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(RoutineDeleteButtonClickedEvent(tRoutineModel));
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockDeleteRoutine(tRoutineModel.id!)).thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expected = [RoutineInitialState(), RoutineLoadingState(), const RoutineErrorState(message: AppStrings.serverFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(RoutineDeleteButtonClickedEvent(tRoutineModel));
    });

    test('should emits [Loading, Error] with a proper message for the error when getting data fails', () async* {
      //arrange
      when(mockDeleteRoutine(tRoutineModel.id!)).thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expected = [RoutineInitialState(), RoutineLoadingState(), const RoutineErrorState(message: AppStrings.cacheFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(RoutineDeleteButtonClickedEvent(tRoutineModel));
    });
  });
}
