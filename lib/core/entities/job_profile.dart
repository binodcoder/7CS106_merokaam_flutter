class JobProfile {
  int? userAccountId;
  String firstName;
  String lastName;
  String city;
  String state;
  String country;
  String workAuthorization;
  String employmentType;
  String? resume;
  String? profilePhoto;
  String? photosImagePath;
  double? duration;

  JobProfile({
    this.userAccountId,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.country,
    required this.workAuthorization,
    required this.employmentType,
    this.resume,
    this.profilePhoto,
    this.photosImagePath,
    this.duration,
  });
}
