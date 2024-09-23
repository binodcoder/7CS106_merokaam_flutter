import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/create_job_profile.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/update_job_profile.dart';
import 'package:merokaam/layers/presentation/JobProfile/add_update_job_profile/bloc/create_job_profile_bloc.dart';
import 'package:merokaam/layers/presentation/JobProfile/add_update_job_profile/bloc/create_job_profile_bloc_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/add_update_job_profile/bloc/create_job_profile_bloc_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_job_profile_bloc_test.mocks.dart';

@GenerateMocks([CreateJobProfile, UpdateJobProfile])
void main() {
  late CreateJobProfileBloc bloc;
  late MockCreateJobProfile mockCreateJobProfile;
  late MockUpdateJobProfile mockUpdateJobProfile;

  setUp(() {
    mockCreateJobProfile = MockCreateJobProfile();
    mockUpdateJobProfile = MockUpdateJobProfile();
    bloc = CreateJobProfileBloc(createJobProfile: mockCreateJobProfile, updateJobProfile: mockUpdateJobProfile);
  });

  test('initialState should be JobProfileAddInitialState', () {
    expect(bloc.state, isA<JobProfileAddInitialState>());
  });

  group('JobProfileAddSaveButtonPressEvent', () {
    final tJobProfile = JobProfile(
      userAccountId: 1,
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

    test('should get data from the createJobProfile use case', () async {
      // arrange
      when(mockCreateJobProfile(any)).thenAnswer((_) async => const Right(1));

      // act
      bloc.add(JobProfileAddSaveButtonPressEvent(tJobProfile));
      await untilCalled(mockCreateJobProfile(any));

      // assert
      verify(mockCreateJobProfile(tJobProfile));
    });

    blocTest<CreateJobProfileBloc, CreateJobProfileState>(
      'should emit [AddJobProfileLoadingState, AddJobProfileSavedState] when data is successfully saved',
      build: () {
        when(mockCreateJobProfile(any)).thenAnswer((_) async => const Right(1));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileAddSaveButtonPressEvent(tJobProfile)),
      expect: () => [
        isA<AddJobProfileLoadingState>(),
        isA<AddJobProfileSavedState>(),
      ],
    );

    blocTest<CreateJobProfileBloc, CreateJobProfileState>(
      'should emit [AddJobProfileLoadingState, AddJobProfileErrorState] when saving fails with ServerFailure',
      build: () {
        when(mockCreateJobProfile(any)).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileAddSaveButtonPressEvent(tJobProfile)),
      expect: () => [
        isA<AddJobProfileLoadingState>(),
        isA<AddJobProfileErrorState>(),
      ],
    );
  });

  group('JobProfileAddUpdateButtonPressEvent', () {
    final tUpdatedJobProfile = JobProfile(
      userAccountId: 1,
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

    test('should call the updateJobProfile use case', () async {
      when(mockUpdateJobProfile(any)).thenAnswer((_) async => const Right(1));

      bloc.add(JobProfileAddUpdateButtonPressEvent(tUpdatedJobProfile));
      await untilCalled(mockUpdateJobProfile(any));

      verify(mockUpdateJobProfile(tUpdatedJobProfile));
    });

    blocTest<CreateJobProfileBloc, CreateJobProfileState>(
      'should emit [AddJobProfileLoadingState, AddJobProfileUpdatedState] when data is successfully updated',
      build: () {
        when(mockUpdateJobProfile(any)).thenAnswer((_) async => const Right(1));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileAddUpdateButtonPressEvent(tUpdatedJobProfile)),
      expect: () => [
        isA<AddJobProfileLoadingState>(),
        isA<AddJobProfileUpdatedState>(),
      ],
    );

    blocTest<CreateJobProfileBloc, CreateJobProfileState>(
      'should emit [AddJobProfileLoadingState, AddJobProfileErrorState] when update fails with ServerFailure',
      build: () {
        when(mockUpdateJobProfile(any)).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(JobProfileAddUpdateButtonPressEvent(tUpdatedJobProfile)),
      expect: () => [
        isA<AddJobProfileLoadingState>(),
        isA<AddJobProfileErrorState>(),
      ],
    );
  });
}
