import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.prefixAssetPath,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.textAlign = TextAlign.start,
  });

  final String hintText;
  final IconData? prefixIcon;
  final String? prefixAssetPath;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLength: maxLength,
      textAlign: textAlign,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.inputHint,
        counterText: '',
        prefixIcon: prefixAssetPath != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  prefixAssetPath!,
                  width: 20,
                  height: 20,
                  color: AppColors.textGrey,
                ),
              )
            : (prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.textGrey)
                  : null),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
