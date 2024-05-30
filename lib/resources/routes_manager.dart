import 'package:flutter/material.dart';
import 'package:merokaam/layers/presentation/login/ui/login_screen.dart';
import 'package:merokaam/layers/presentation/register/ui/register_page.dart';
import 'package:merokaam/resources/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
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
