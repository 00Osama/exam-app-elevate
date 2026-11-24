import 'package:exam_app_elevate/features/auth/login/presentation/view/sign_in_view.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:exam_app_elevate/features/default_navigation_screen.dart';
import 'package:exam_app_elevate/features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:exam_app_elevate/core/constants/app_routes.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(builder: (_) => const DefaultView());
    }
  }
}
