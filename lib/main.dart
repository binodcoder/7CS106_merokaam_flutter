import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:merokaam/resources/routes_manager.dart';
import 'package:merokaam/resources/strings_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

import 'layers/presentation/register/bloc/user_add_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.getRoute,
        debugShowCheckedModeBanner: false,
        title: AppStrings.titleLabel,
        initialRoute: Routes.loginRoute,
      ),
    );
  }
}
