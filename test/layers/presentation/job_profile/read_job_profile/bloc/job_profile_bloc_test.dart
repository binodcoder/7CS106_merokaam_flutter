import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/mappers/map_exception_to_failure.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/read_job_profile.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_bloc.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'job_profile_bloc_test.mocks.dart';

@GenerateMocks([ReadJobProfile])
void main() {
  late ReadJobProfileBloc bloc;
  late MockReadJobProfile mockReadJobProfile;

  setUp(() {
    mockReadJobProfile = MockReadJobProfile();
    bloc = ReadJobProfileBloc(readJobProfiles: mockReadJobProfile);
  });

  test('initialState should be JobProfileInitialState', () {
    expect(bloc.state, equals(JobProfileInitialState()));
  });

  group('JobProfileInitialEvent', () {
    final tJobProfile = JobProfile(
      userAccountId: 0,
      firstName: 'John',
      lastName: 'Doe',
      city: 'City',
      state: 'State',
      country: 'Country',
      workAuthorization: 'Authorized',
      employmentType: 'Full-Time',
      resume: 'Resume Link',
      profilePhoto: 'Profile Photo Link',
      photosImagePath: 'Image Path',
    );

    test('should get data from the use case', () async {
      // arrange
      when(mockReadJobProfile(any)).thenAnswer((_) async => Right(tJobProfile));

      // act
      bloc.add(JobProfileInitialEvent(1));
      await untilCalled(mockReadJobProfile(any));

      // assert
      verify(mockReadJobProfile(1));
    });

    blocTest<ReadJobProfileBloc, ReadJobProfileState>(
      'should emit [Loading, Loaded] when data is retrieved successfully',
      build: () {
        when(mockReadJobProfile(any)).thenAnswer((_) async => Right(tJobProfile));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileInitialEvent(1)),
      expect: () => [
        JobProfileLoadingState(),
        JobProfileLoadedSuccessState(tJobProfile),
      ],
    );

    blocTest<ReadJobProfileBloc, ReadJobProfileState>(
      'should emit [Loading, Error] when getting data fails with ServerFailure',
      build: () {
        when(mockReadJobProfile(any)).thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileInitialEvent(1)),
      expect: () => [
        JobProfileLoadingState(),
        JobProfileErrorState(ServerFailure()),
      ],
    );

    blocTest<ReadJobProfileBloc, ReadJobProfileState>(
      'should emit [Loading, Error] with proper message when getting data fails with CacheFailure',
      build: () {
        when(mockReadJobProfile(any)).thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileInitialEvent(1)),
      expect: () => [
        JobProfileLoadingState(),
        JobProfileErrorState(CacheFailure()),
      ],
    );
  });

  group('JobProfileEditButtonClickedEvent', () {
    final tJobProfile = JobProfile(
      userAccountId: 0,
      firstName: 'John',
      lastName: 'Doe',
      city: 'City',
      state: 'State',
      country: 'Country',
      workAuthorization: 'Authorized',
      employmentType: 'Full-Time',
      resume: 'Resume Link',
      profilePhoto: 'Profile Photo Link',
      photosImagePath: 'Image Path',
    );

    blocTest<ReadJobProfileBloc, ReadJobProfileState>(
      'should emit [NavigateToUpdatePage] when JobProfileEditButtonClickedEvent is triggered',
      build: () => bloc,
      act: (bloc) => bloc.add(JobProfileEditButtonClickedEvent(tJobProfile)),
      expect: () => [
        JobProfileNavigateToUpdatePageActionState(tJobProfile),
      ],
    );
  });

  group('JobProfileAddButtonClickedEvent', () {
    blocTest<ReadJobProfileBloc, ReadJobProfileState>(
      'should emit [NavigateToAddJobProfile] when JobProfileAddButtonClickedEvent is triggered',
      build: () => bloc,
      act: (bloc) => bloc.add(JobProfileAddButtonClickedEvent()),
      expect: () => [
        JobProfileNavigateToAddJobProfileActionState(),
      ],
    );
  });
}
