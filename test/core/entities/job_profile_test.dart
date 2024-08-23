import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/job_profile.dart';

void main() {
  group('JobProfile', () {
    test('Constructor should initialize all fields correctly', () {
      final jobProfile = JobProfile(
        userAccountId: 1,
        firstName: 'John',
        lastName: 'Doe',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        workAuthorization: 'Authorized',
        employmentType: 'Full-Time',
        resume: 'resume.pdf',
        profilePhoto: 'profile.jpg',
        photosImagePath: '/images/profile',
        duration: 12.5,
      );

      expect(jobProfile.userAccountId, 1);
      expect(jobProfile.firstName, 'John');
      expect(jobProfile.lastName, 'Doe');
      expect(jobProfile.city, 'New York');
      expect(jobProfile.state, 'NY');
      expect(jobProfile.country, 'USA');
      expect(jobProfile.workAuthorization, 'Authorized');
      expect(jobProfile.employmentType, 'Full-Time');
      expect(jobProfile.resume, 'resume.pdf');
      expect(jobProfile.profilePhoto, 'profile.jpg');
      expect(jobProfile.photosImagePath, '/images/profile');
      expect(jobProfile.duration, 12.5);
    });

    test('Duration can be null', () {
      final jobProfile = JobProfile(
        userAccountId: 2,
        firstName: 'Jane',
        lastName: 'Doe',
        city: 'Los Angeles',
        state: 'CA',
        country: 'USA',
        workAuthorization: 'Authorized',
        employmentType: 'Part-Time',
        resume: 'resume.pdf',
        profilePhoto: 'profile.jpg',
        photosImagePath: '/images/profile',
      );

      expect(jobProfile.duration, isNull);
    });

    test('Duration should be a double or null', () {
      final jobProfileWithDuration = JobProfile(
        userAccountId: 3,
        firstName: 'Alice',
        lastName: 'Smith',
        city: 'Chicago',
        state: 'IL',
        country: 'USA',
        workAuthorization: 'Not Authorized',
        employmentType: 'Contract',
        resume: 'resume.pdf',
        profilePhoto: 'profile.jpg',
        photosImagePath: '/images/profile',
        duration: 6.0,
      );

      final jobProfileWithoutDuration = JobProfile(
        userAccountId: 4,
        firstName: 'Bob',
        lastName: 'Johnson',
        city: 'Houston',
        state: 'TX',
        country: 'USA',
        workAuthorization: 'Authorized',
        employmentType: 'Full-Time',
        resume: 'resume.pdf',
        profilePhoto: 'profile.jpg',
        photosImagePath: '/images/profile',
      );

      expect(jobProfileWithDuration.duration, isA<double>());
      expect(jobProfileWithoutDuration.duration, isNull);
    });

    test('All fields should hold the correct data types', () {
      final jobProfile = JobProfile(
        userAccountId: 5,
        firstName: 'Charlie',
        lastName: 'Brown',
        city: 'Phoenix',
        state: 'AZ',
        country: 'USA',
        workAuthorization: 'Authorized',
        employmentType: 'Internship',
        resume: 'resume.pdf',
        profilePhoto: 'profile.jpg',
        photosImagePath: '/images/profile',
        duration: 3.0,
      );

      expect(jobProfile.userAccountId, isA<int>());
      expect(jobProfile.firstName, isA<String>());
      expect(jobProfile.lastName, isA<String>());
      expect(jobProfile.city, isA<String>());
      expect(jobProfile.state, isA<String>());
      expect(jobProfile.country, isA<String>());
      expect(jobProfile.workAuthorization, isA<String>());
      expect(jobProfile.employmentType, isA<String>());
      expect(jobProfile.resume, isA<String>());
      expect(jobProfile.profilePhoto, isA<String>());
      expect(jobProfile.photosImagePath, isA<String>());
      expect(jobProfile.duration, isA<double?>());
    });
  });
}
