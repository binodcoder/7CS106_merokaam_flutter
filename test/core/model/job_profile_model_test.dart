import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'dart:convert';
import '../../fixtures/fixture_reader.dart';

void main() {
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
    duration: 1.1,
  );

  test('should be a subclass of JobProfile model', () async {
    //assert
    expect(tJobProfileModel, isA<JobProfileModel>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('job_profile.json'));
      //act
      final result = JobProfileModel.fromJson(jsonMap);
      //assert
      expect(result.userAccountId, equals(tJobProfileModel.userAccountId));
    });

    test('should return a valid model when the JSON duration is regarded as a double', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('job_profile_duration_double.json'));
      //act
      final result = JobProfileModel.fromJson(jsonMap);
      //assert
      expect(result.duration, equals(tJobProfileModel.duration));
    });
  });

  group('toJson', () {
    test('should return ', () async {
      //act
      final result = tJobProfileModel.toJson();
      //assert
      final expectedMap = {
        "userAccountId": 0,
        "firstName": '',
        "lastName": '',
        "city": '',
        "state": '',
        "country": '',
        "workAuthorization": '',
        "employmentType": '',
        "resume": '',
        "profilePhoto": '',
        "photosImagePath": '',
        "duration": 1.1,
      };
      expect(result, equals(expectedMap));
    });
  });
}
