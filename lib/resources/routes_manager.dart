import 'package:flutter/material.dart';
import 'package:merokaam/layers/presentation/login/ui/login_screen.dart';
import 'package:merokaam/layers/presentation/register/ui/register_page.dart';
import 'package:merokaam/resources/strings_manager.dart';

import '../layers/presentation/JobProfile/add_update_job_profile/ui/create_job_profile_page.dart';
import '../layers/presentation/JobProfile/read_job_profile/ui/read_job_profile_page.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String createJobProfileRoute = "/create_job_profile";
  static const String jobProfileRoute = "/job_profile";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case Routes.createJobProfileRoute:
        return MaterialPageRoute(builder: (context) => const CreateJobProfilePage());
      case Routes.jobProfileRoute:
        return MaterialPageRoute(builder: (context) => const ReadJobProfilePage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.noRouteFound,
            ),
          ),
          body: const Center(
            child: Text(AppStrings.noRouteFound),
          )),
    );
  }
}
