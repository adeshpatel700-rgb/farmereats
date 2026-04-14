import 'package:farmer_eats/core/storage/secure_storage.dart';
import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }

    final token = await SecureStorage.getToken();
    if (!mounted) {
      return;
    }
    if (token != null && token.isNotEmpty) {
      context.go('/home');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;
    context.go(onboardingDone ? '/login' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'FarmerEats',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
