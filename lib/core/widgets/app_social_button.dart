import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppSocialButton extends StatelessWidget {
  const AppSocialButton({super.key, required this.child, this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          side: const BorderSide(color: AppColors.socialBorder),
          padding: EdgeInsets.zero,
        ),
        child: child,
      ),
    );
  }
}
