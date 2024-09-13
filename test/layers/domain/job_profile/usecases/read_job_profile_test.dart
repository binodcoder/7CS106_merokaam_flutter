import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/core/usecases/usecase.dart';
import 'package:merokaam/layers/domain/job_profile/repositories/job_profile_repositories.dart';
import 'package:merokaam/layers/domain/job_profile/usecases/read_job_profile.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockJobProfileRepository extends Mock implements JobProfileRepository {}

void main() {
  late ReadJobProfile usecase;
  late MockJobProfileRepository mockJobProfileRepository;
  setUp(() {
    mockJobProfileRepository = MockJobProfileRepository();
    usecase = ReadJobProfile(mockJobProfileRepository);
  });

  JobProfileModel tJobProfile = JobProfileModel(
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
    'should get all blog post from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When readJobProfile is called with any argument, always answer with
      // the Right "side" of Either containing a test Post object.
      when(mockJobProfileRepository.readJobProfile(1)).thenAnswer((_) async => Right(tJobProfile));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(1);
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tJobProfile));
      // Verify that the method has been called on the Repository
      verify(mockJobProfileRepository.readJobProfile(1));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockJobProfileRepository);
    },
  );
}
