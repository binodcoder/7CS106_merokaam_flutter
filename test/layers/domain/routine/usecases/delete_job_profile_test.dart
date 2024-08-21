import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/domain/job_profile/repositories/job_profile_repositories.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/delete_job_profile.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockJobProfileRepository extends Mock implements JobProfileRepository {}

void main() {
  late DeleteJobProfile usecase;
  late MockJobProfileRepository mockJobProfileRepository;
  setUp(() {
    mockJobProfileRepository = MockJobProfileRepository();
    usecase = DeleteJobProfile(mockJobProfileRepository);
  });

  int tResponse = 1;

  JobProfileModel tJobProfileModel = JobProfileModel(
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

  test(
    'should get int from the repository',
    () async {
      when(mockJobProfileRepository.deleteJobProfile(tJobProfileModel!)).thenAnswer((_) async => Right(tResponse));
      final result = await usecase(tJobProfileModel!);
      expect(result, Right(tResponse));
      verify(mockJobProfileRepository.deleteJobProfile(tJobProfileModel!));
      verifyNoMoreInteractions(mockJobProfileRepository);
    },
  );
}
