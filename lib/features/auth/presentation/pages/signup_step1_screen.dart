import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/utils/validators.dart';
import 'package:farmer_eats/core/widgets/app_input_field.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/core/widgets/app_social_button.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupStep1Screen extends StatefulWidget {
  const SignupStep1Screen({super.key});

  @override
  State<SignupStep1Screen> createState() => _SignupStep1ScreenState();
}

class _SignupStep1ScreenState extends State<SignupStep1Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
          child: Row(
            children: [
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Login', style: AppTextStyles.link),
              ),
              const Spacer(),
              SizedBox(
                width: 180,
                child: AppPrimaryButton(
                  label: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<SignupCubit>().updateStep1(
                        fullName: _fullNameController.text.trim(),
                        email: _emailController.text.trim(),
                        phone: _phoneController.text.trim(),
                        password: _passwordController.text,
                      );
                      context.go('/signup/step2');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const Text('FarmerEats', style: AppTextStyles.appName),
                  const SizedBox(height: 6),
                  const Text('Signup 1 of 4', style: AppTextStyles.stepLabel),
                  const SizedBox(height: 6),
                  Image.asset(
                    AppAssets.progressDivider,
                    width: 120,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 8),
                  const Text('Welcome!', style: AppTextStyles.headline),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(
                        child: AppSocialButton(child: Text('Google')),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppSocialButton(
                          child: Image.asset(
                            AppAssets.logoApple,
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppSocialButton(
                          child: Image.asset(
                            AppAssets.logoFacebook,
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: Text('or signup with', style: AppTextStyles.body),
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Full Name',
                    prefixAssetPath: AppAssets.iconPerson,
                    controller: _fullNameController,
                    validator: Validators.validateRequired,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Email Address',
                    prefixAssetPath: AppAssets.iconEmailAlt,
                    controller: _emailController,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Phone Number',
                    prefixAssetPath: AppAssets.iconPhone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: Validators.validatePhone,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Password',
                    prefixAssetPath: AppAssets.iconLock,
                    controller: _passwordController,
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Re-enter Password',
                    prefixAssetPath: AppAssets.iconLock,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) => Validators.validatePasswordMatch(
                      _passwordController.text,
                      value,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
