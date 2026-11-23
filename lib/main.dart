import 'package:exam_app_elevate/Config/Di/di.dart';
import 'package:exam_app_elevate/core/theme/app_theme.dart';
import 'package:exam_app_elevate/features/splash/spash_view.dart';
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
