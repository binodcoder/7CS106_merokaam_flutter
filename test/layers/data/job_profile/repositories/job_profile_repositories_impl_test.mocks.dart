// Mocks generated by Mockito 5.4.4 from annotations
// in merokaam/test/layers/data/job_profile/repositories/job_profile_repositories_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:merokaam/core/models/job_profile_model.dart' as _i2;
import 'package:merokaam/core/network/network_info.dart' as _i6;
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart'
    as _i3;
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeJobProfileModel_0 extends _i1.SmartFake
    implements _i2.JobProfileModel {
  _FakeJobProfileModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [JobProfilesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJobProfilesLocalDataSource extends _i1.Mock
    implements _i3.JobProfilesLocalDataSource {
  MockJobProfilesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.JobProfileModel> readLastJobProfile(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #readLastJobProfile,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.JobProfileModel>.value(_FakeJobProfileModel_0(
          this,
          Invocation.method(
            #readLastJobProfile,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.JobProfileModel>);

  @override
  _i4.Future<int>? cacheJobProfile(_i2.JobProfileModel? jobProfileModel) =>
      (super.noSuchMethod(Invocation.method(
        #cacheJobProfile,
        [jobProfileModel],
      )) as _i4.Future<int>?);
}

/// A class which mocks [JobProfileRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJobProfileRemoteDataSource extends _i1.Mock
    implements _i5.JobProfileRemoteDataSource {
  MockJobProfileRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.JobProfileModel> readJobProfile(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #readJobProfile,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.JobProfileModel>.value(_FakeJobProfileModel_0(
          this,
          Invocation.method(
            #readJobProfile,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.JobProfileModel>);

  @override
  _i4.Future<int> deleteJobProfile(int? userAccountId) => (super.noSuchMethod(
        Invocation.method(
          #deleteJobProfile,
          [userAccountId],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> createJobProfile(_i2.JobProfileModel? postModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #createJobProfile,
          [postModel],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> updateJobProfile(_i2.JobProfileModel? postModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateJobProfile,
          [postModel],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
