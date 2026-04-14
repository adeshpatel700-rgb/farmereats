import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/utils/validators.dart';
import 'package:farmer_eats/core/widgets/app_input_field.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/core/widgets/app_social_button.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/login_cubit.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/login_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          context.go('/home');
        }
        if (state.status == LoginStatus.failure && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
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
                      const SizedBox(height: 60),
                      const Text(
                        'Welcome back!',
                        style: AppTextStyles.headline,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('New here? ', style: AppTextStyles.body),
                          TextButton(
                            onPressed: () => context.go('/signup/step1'),
                            child: const Text(
                              'Create account',
                              style: AppTextStyles.link,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      AppInputField(
                        hintText: 'Email Address',
                        prefixAssetPath: AppAssets.iconEmail,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      AppInputField(
                        hintText: 'Password',
                        prefixAssetPath: AppAssets.iconLock,
                        controller: _passwordController,
                        obscureText: true,
                        validator: Validators.validatePassword,
                        suffix: TextButton(
                          onPressed: () => context.go('/forgot-password'),
                          child: const Text(
                            'Forgot?',
                            style: AppTextStyles.link,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppPrimaryButton(
                        label: 'Login',
                        isLoading: state.status == LoginStatus.loading,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LoginCubit>().login(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      const Center(
                        child: Text('or login with', style: AppTextStyles.body),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppSocialButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Google login coming soon.'),
                                  ),
                                );
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.google,
                                size: 20,
                                color: Color(0xFFDB4437),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppSocialButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Apple login coming soon.'),
                                  ),
                                );
                              },
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
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Facebook login coming soon.',
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset(
                                AppAssets.logoFacebook,
                                width: 22,
                                height: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
