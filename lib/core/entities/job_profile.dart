class JobProfileEntity {
  int userAccountId;
  String firstName;
  String lastName;
  String city;
  String state;
  String country;
  String workAuthorization;
  String employmentType;
  String resume;
  String profilePhoto;
  String photosImagePath;

  JobProfileEntity({
    required this.userAccountId,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.country,
    required this.workAuthorization,
    required this.employmentType,
    required this.resume,
    required this.profilePhoto,
    required this.photosImagePath,
  });
}
