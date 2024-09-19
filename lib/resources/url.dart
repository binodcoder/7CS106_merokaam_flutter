class AppUrl {
  // static const String baseUrl = "http://192.168.1.180:5000";

  static const String baseUrl = "http://mero-kaam-env.eba-ejt2pjwd.eu-north-1.elasticbeanstalk.com";

  // auth
  static const String signin = "$baseUrl/api/auth/signin";
  static const String signup = "$baseUrl/api/auth/signup";

  // job-profile
  static const String create = "$baseUrl/api/job-profile/create";
  static const String profile = "$baseUrl/api/job-profile/profile/";
}
