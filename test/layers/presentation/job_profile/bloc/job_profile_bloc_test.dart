import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/create_job_profile.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/delete_job_profile.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/read_job_profile.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_bloc.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_state.dart';
import 'package:merokaam/resources/strings_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'job_profile_bloc_test.mocks.dart';

@GenerateMocks([ReadJobProfile])
@GenerateMocks([CreateJobProfile])
@GenerateMocks([DeleteJobProfile])
void main() {
  late ReadJobProfileBloc bloc;
  late MockReadJobProfile mockGetJobProfile;
  late MockDeleteJobProfile mockDeleteJobProfile;

  setUp(() {
    mockGetJobProfile = MockReadJobProfile();
    mockDeleteJobProfile = MockDeleteJobProfile();

    bloc = ReadJobProfileBloc(getJobProfiles: mockGetJobProfile, deleteJobProfile: mockDeleteJobProfile);
  });

  test('initialState should be JobProfileInitialState', () async {
    //assert
    expect(bloc.initialState, equals(JobProfileInitialState()));
  });

  group('GetJobProfile', () {
    final tJobProfileModel = JobProfileModel(
      userAccountId: 0,
      firstName: '',
      lastName: '',
      city: '',
      state: '',
      country: '',
      workAuthorization: '',
      employmentType: '',
      resume: '',
      profilePhoto: '',
      photosImagePath: '',
    );

    test('should get data from the JobProfile usecase', () async* {
      //arrange

      when(mockGetJobProfile(any)).thenAnswer((_) async => Right(tJobProfileModel));
      //act
      bloc.add(JobProfileInitialEvent(1));
      await untilCalled(mockGetJobProfile(any));

      //assert
      verify(mockGetJobProfile(any));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange

      when(mockGetJobProfile(any)).thenAnswer((_) async => Right(tJobProfileModel));

      //assert later
      final expected = [JobProfileInitialState(), JobProfileLoadingState(), JobProfileLoadedSuccessState(tJobProfileModel)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(JobProfileInitialEvent());
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange

      when(mockGetJobProfile(any)).thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expected = [JobProfileInitialState(), JobProfileLoadingState(), const JobProfileErrorState(message: AppStrings.serverFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(JobProfileInitialEvent());
    });

    test('should emits [Loading, Error] with a proper message for the error when getting data fails', () async* {
      //arrange

      when(mockGetJobProfile(any)).thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expected = [JobProfileInitialState(), JobProfileLoadingState(), const JobProfileErrorState(message: AppStrings.cacheFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(JobProfileInitialEvent(1));
    });
  });

  group('DeleteJobProfile', () {
    final tJobProfileModel = JobProfileModel(
      userAccountId: 0,
      firstName: '',
      lastName: '',
      city: '',
      state: '',
      country: '',
      workAuthorization: '',
      employmentType: '',
      resume: '',
      profilePhoto: '',
      photosImagePath: '',
    );

    test('should get int from the delete use case', () async* {
      //arrange
      when(mockDeleteJobProfile(tJobProfileModel!)).thenAnswer((_) async => const Right(1));
      //act
      bloc.add(JobProfileDeleteButtonClickedEvent(tJobProfileModel));
      await untilCalled(mockDeleteJobProfile(tJobProfileModel));

      //assert
      verify(mockDeleteJobProfile(tJobProfileModel!));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange
      when(mockDeleteJobProfile(tJobProfileModel!)).thenAnswer((_) async => const Right(1));

      //assert later
      final expected = [JobProfileInitialState(), JobProfileLoadingState(), JobProfileLoadedSuccessState(tJobProfileModel)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(JobProfileDeleteButtonClickedEvent(tJobProfileModel));
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockDeleteJobProfile(tJobProfileModel!)).thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expected = [JobProfileInitialState(), JobProfileLoadingState(), const JobProfileErrorState(message: AppStrings.serverFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(JobProfileDeleteButtonClickedEvent(tJobProfileModel));
    });

    test('should emits [Loading, Error] with a proper message for the error when getting data fails', () async* {
      //arrange
      when(mockDeleteJobProfile(tJobProfileModel!)).thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expected = [JobProfileInitialState(), JobProfileLoadingState(), const JobProfileErrorState(message: AppStrings.cacheFailureMessage)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(JobProfileDeleteButtonClickedEvent(tJobProfileModel));
    });
  });
}
