import 'package:exam_app_elevate/config/di/di.dart';
import 'package:exam_app_elevate/core/theme/light_theme.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/view/sign_in_view.dart';
// ignore: deprecated_member_use
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
      home: const SignInView()
    );
  }
}
