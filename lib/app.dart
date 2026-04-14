import 'package:farmer_eats/core/storage/secure_storage.dart';
import 'package:farmer_eats/core/theme/app_theme.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/login_cubit.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:farmer_eats/features/auth/presentation/pages/confirmation_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/login_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/signup_step1_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/signup_step2_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/signup_step3_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/signup_step4_screen.dart';
import 'package:farmer_eats/features/auth/presentation/pages/verify_otp_screen.dart';
import 'package:farmer_eats/features/home/presentation/pages/home_screen.dart';
import 'package:farmer_eats/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:farmer_eats/features/splash/presentation/pages/splash_screen.dart';
import 'package:farmer_eats/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerEatsApp extends StatelessWidget {
  FarmerEatsApp({super.key});

  static const Set<String> _authFlowPaths = <String>{
    '/login',
    '/signup/step1',
    '/signup/step2',
    '/signup/step3',
    '/signup/step4',
    '/forgot-password',
    '/verify-otp',
    '/reset-password',
    '/confirmation',
  };

  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final String location = state.uri.path;
      final String? token = await SecureStorage.getToken();
      final bool loggedIn = token != null && token.isNotEmpty;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool onboardingDone = prefs.getBool('onboarding_done') ?? false;

      if (location == '/splash') {
        return null;
      }

      if (loggedIn) {
        return location == '/home' ? null : '/home';
      }

      if (!onboardingDone) {
        return location == '/onboarding' || _authFlowPaths.contains(location)
            ? null
            : '/onboarding';
      }

      if (location == '/onboarding') {
        return '/login';
      }

      if (location == '/home') {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider<LoginCubit>(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup/step1',
        builder: (context, state) => BlocProvider.value(
          value: getIt<SignupCubit>(),
          child: const SignupStep1Screen(),
        ),
      ),
      GoRoute(
        path: '/signup/step2',
        builder: (context, state) => BlocProvider.value(
          value: getIt<SignupCubit>(),
          child: const SignupStep2Screen(),
        ),
      ),
      GoRoute(
        path: '/signup/step3',
        builder: (context, state) => BlocProvider.value(
          value: getIt<SignupCubit>(),
          child: const SignupStep3Screen(),
        ),
      ),
      GoRoute(
        path: '/signup/step4',
        builder: (context, state) => BlocProvider.value(
          value: getIt<SignupCubit>(),
          child: const SignupStep4Screen(),
        ),
      ),
      GoRoute(
        path: '/confirmation',
        builder: (context, state) => BlocProvider.value(
          value: getIt<SignupCubit>(),
          child: const ConfirmationScreen(),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final mobile = state.extra is String ? state.extra! as String : null;
          return VerifyOtpScreen(mobile: mobile);
        },
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          final token = state.extra is String ? state.extra! as String : '';
          return ResetPasswordScreen(token: token);
        },
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FarmerEats',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
