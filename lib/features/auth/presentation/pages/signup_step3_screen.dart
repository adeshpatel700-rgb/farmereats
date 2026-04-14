import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/widgets/app_file_chip.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class SignupStep3Screen extends StatefulWidget {
  const SignupStep3Screen({super.key});

  @override
  State<SignupStep3Screen> createState() => _SignupStep3ScreenState();
}

class _SignupStep3ScreenState extends State<SignupStep3Screen> {
  File? _selectedFile;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.go('/signup/step2');
  }

  @override
  void initState() {
    super.initState();
    _selectedFile = context.read<SignupCubit>().state.registrationProof;
  }

  Future<void> _pickFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() => _selectedFile = File(image.path));
    }
  }

  Future<void> _pickFromFiles() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _selectedFile = File(result.files.single.path!));
    }
  }

  Future<void> _showPickerOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(
                  AppAssets.iconCamera,
                  width: 20,
                  height: 20,
                ),
                title: const Text('Take Photo'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_file),
                title: const Text('Choose File'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickFromFiles();
                },
              ),
            ],
          ),
        );
      },
    );
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
              IconButton(
                onPressed: _handleBack,
                icon: Image.asset(AppAssets.iconBack, width: 20, height: 20),
              ),
              const Spacer(),
              SizedBox(
                width: 180,
                child: AppPrimaryButton(
                  label: 'Continue',
                  onPressed: () {
                    if (_selectedFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please attach proof of registration to continue.',
                          ),
                        ),
                      );
                      return;
                    }
                    context.read<SignupCubit>().updateStep3(_selectedFile);
                    context.go('/signup/step4');
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Text('FarmerEats', style: AppTextStyles.appName),
                const SizedBox(height: 6),
                const Text('Signup 3 of 4', style: AppTextStyles.stepLabel),
                const SizedBox(height: 6),
                Image.asset(
                  AppAssets.progressDivider,
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 8),
                const Text('Verification', style: AppTextStyles.headline),
                const SizedBox(height: 12),
                const Text(
                  'Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Attach proof of registration',
                        style: AppTextStyles.inputText,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: _showPickerOptions,
                      mini: true,
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      child: Image.asset(
                        AppAssets.iconCamera,
                        width: 18,
                        height: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_selectedFile != null)
                  AppFileChip(
                    fileName: _selectedFile!.path.split(RegExp(r'[/\\]')).last,
                    onRemove: () => setState(() => _selectedFile = null),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
