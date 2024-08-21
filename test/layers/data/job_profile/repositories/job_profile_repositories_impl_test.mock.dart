// Mocks generated by Mockito 5.4.2 from annotations
// in merokaam/layers/data/JobProfile/repositories/JobProfile_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as i4;

import 'package:merokaam/core/models/job_profile_model.dart' as i2;
import 'package:merokaam/core/network/network_info.dart' as i3;
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart' as i5;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeJobProfileModel_0 extends i1.Fake implements i2.JobProfileModel {}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends i1.Mock implements i3.NetworkInfo {
  MockNetworkInfo() {
    i1.throwOnMissingStub(this);
  }

  @override
  i4.Future<bool> get isConnected => (super.noSuchMethod(Invocation.getter(#isConnected),
      returnValue: Future<bool>.value(false), returnValueForMissingStub: Future<bool>.value(true)) as i4.Future<bool>);
}

/// A class which mocks [JobProfilesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJobProfilesRemoteDataSource extends i1.Mock implements i5.JobProfileRemoteDataSource {
  MockJobProfilesRemoteDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i4.Future<List<i2.JobProfileModel>> getJobProfiles() => (super.noSuchMethod(Invocation.method(#ggetJobProfiles, []),
      returnValue: Future<List<i2.JobProfileModel>>.value([_FakeJobProfileModel_0()]),
      returnValueForMissingStub: Future<List<i2.JobProfileModel>>.value([_FakeJobProfileModel_0()])) as i4.Future<List<i2.JobProfileModel>>);
  @override
  i4.Future<int> deleteJobProfile(int? number) => (super.noSuchMethod(Invocation.method(#deleteJobProfile, [number]),
      returnValue: Future<int>.value(1), returnValueForMissingStub: Future<int>.value(1)) as i4.Future<int>);
}
