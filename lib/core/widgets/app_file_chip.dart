import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppFileChip extends StatelessWidget {
  const AppFileChip({
    super.key,
    required this.fileName,
    required this.onRemove,
  });

  final String fileName;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                color: AppColors.textDark,
                decoration: TextDecoration.underline,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Image.asset(AppAssets.iconClose, width: 14, height: 14),
            onPressed: onRemove,
            splashRadius: 18,
          ),
        ],
      ),
    );
  }
}
