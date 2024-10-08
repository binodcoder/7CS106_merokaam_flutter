import 'package:merokaam/core/entities/job_profile.dart';
import 'dart:convert';

List<JobProfileModel> jobProfileModelsFromMap(String str) => List<JobProfileModel>.from(json.decode(str).map((x) => JobProfileModel.fromJson(x)));

String jobProfileModelToJson(JobProfileModel data) => json.encode(data.toJson());

class JobProfileModel extends JobProfile {
  JobProfileModel({
    super.userAccountId,
    required super.firstName,
    required super.lastName,
    required super.city,
    required super.state,
    required super.country,
    required super.workAuthorization,
    required super.employmentType,
    super.resume,
    super.profilePhoto,
    super.photosImagePath,
    super.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      "userAccountId": userAccountId,
      "firstName": firstName,
      "lastName": lastName,
      "city": city,
      "state": state,
      "country": country,
      "workAuthorization": workAuthorization,
      "employmentType": employmentType,
      "resume": resume,
      "profilePhoto": profilePhoto,
      "photosImagePath": photosImagePath,
      "duration": duration,
    };
  }

  factory JobProfileModel.fromJson(Map<String, dynamic> map) {
    return JobProfileModel(
      userAccountId: map['userAccountId'],
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      city: map['city'] ?? "",
      state: map['state'] ?? "",
      country: map['country'] ?? "",
      workAuthorization: map['workAuthorization'] ?? "",
      employmentType: map['employmentType'] ?? "",
      resume: map['resume'] ?? "",
      profilePhoto: map['profilePhoto'] ?? "",
      photosImagePath: map['photosImagePath'] ?? "",
      duration: map['duration'] ?? 0.0,
    );
  }

  copyWith({required userAccountId}) {}
}
