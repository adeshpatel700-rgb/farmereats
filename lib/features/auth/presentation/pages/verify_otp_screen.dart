import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/utils/validators.dart';
import 'package:farmer_eats/core/widgets/app_input_field.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmer_eats/injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, this.mobile});

  final String? mobile;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.go('/forgot-password');
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final token = await getIt<AuthRepository>().verifyOtp(
        _otpController.text.trim(),
      );
      if (!mounted) {
        return;
      }
      context.go('/reset-password', extra: token);
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

  Future<void> _resendOtp() async {
    final mobile = widget.mobile;
    if (mobile == null || mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mobile number is unavailable for resend.'),
        ),
      );
      return;
    }
    try {
      await getIt<AuthRepository>().forgotPassword(mobile);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP resent successfully.')),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceFirst('Exception: ', '')),
          ),
        );
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
                const Text('Verify OTP', style: AppTextStyles.headline),
                const SizedBox(height: 12),
                const Text(
                  'Enter the 6-digit OTP sent to your mobile.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 24),
                AppInputField(
                  hintText: 'Enter OTP',
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    final requiredMessage = Validators.validateRequired(value);
                    if (requiredMessage != null) {
                      return requiredMessage;
                    }
                    if ((value ?? '').length != 6) {
                      return 'OTP must be 6 digits.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppPrimaryButton(
                  label: 'Verify OTP',
                  isLoading: _isLoading,
                  onPressed: _verifyOtp,
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: _resendOtp,
                    child: const Text('Resend OTP', style: AppTextStyles.link),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
