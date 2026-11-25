import 'package:exam_app_elevate/config/di/di.dart';
import 'package:exam_app_elevate/core/app_rotutes_manager.dart/app_router.dart';
import 'package:exam_app_elevate/core/app_rotutes_manager.dart/app_routes.dart';
import 'package:exam_app_elevate/core/theme/app_light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
