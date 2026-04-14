import 'package:farmer_eats/core/storage/secure_storage.dart';
import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                AppAssets.iconCheck,
                width: 80,
                height: 80,
                color: AppColors.success,
              ),
              const SizedBox(height: 32),
              const Text(
                "You're all done!",
                style: AppTextStyles.headline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Hang tight!  We are currently reviewing your account and will follow up with you in 2-3 business days. In the meantime, you can setup your inventory.',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppPrimaryButton(
                label: 'Got it!',
                onPressed: () async {
                  final token = context.read<SignupCubit>().state.token;
                  if (token != null && token.isNotEmpty) {
                    await SecureStorage.setToken(token);
                  }
                  if (!context.mounted) {
                    return;
                  }
                  context.go('/home');
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
