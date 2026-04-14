import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/utils/validators.dart';
import 'package:farmer_eats/core/widgets/app_input_field.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmer_eats/injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  bool _isLoading = false;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.go('/login');
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      await getIt<AuthRepository>().forgotPassword(
        _mobileController.text.trim(),
      );
      if (!mounted) {
        return;
      }
      context.go('/verify-otp', extra: _mobileController.text.trim());
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceFirst('Exception: ', '')),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Text('FarmerEats', style: AppTextStyles.appName),
                IconButton(
                  onPressed: _handleBack,
                  icon: Image.asset(AppAssets.iconBack, width: 20, height: 20),
                ),
                const Text('Forgot Password', style: AppTextStyles.headline),
                const SizedBox(height: 12),
                const Text(
                  'Enter your registered mobile number to receive an OTP.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 24),
                AppInputField(
                  hintText: 'Mobile Number (+1xxxxxxxxxx)',
                  prefixAssetPath: AppAssets.iconPhone,
                  keyboardType: TextInputType.phone,
                  controller: _mobileController,
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 24),
                AppPrimaryButton(
                  label: 'Send OTP',
                  isLoading: _isLoading,
                  onPressed: _sendOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
