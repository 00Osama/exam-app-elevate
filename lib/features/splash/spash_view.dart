import 'package:exam_app_elevate/config/di/di.dart';
import 'package:exam_app_elevate/core/constants/app_routes.dart';
import 'package:exam_app_elevate/core/theme/app_colors.dart';
import 'package:exam_app_elevate/features/auth/login/domain/use_cases/is_logged_in_use_case.dart';
import 'package:exam_app_elevate/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.7, curve: Curves.easeIn),
    );

    _controller.forward();

    final Future<bool> isLoggedInFuture = getIt<IsLoggedInUseCase>()();

    Future<void>.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await isLoggedInFuture;
      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        isLoggedIn ? AppRoutes.home : AppRoutes.signIn,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              Assets.appSplash.path,
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
