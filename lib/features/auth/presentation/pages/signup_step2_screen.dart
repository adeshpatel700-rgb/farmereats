import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/utils/us_states.dart';
import 'package:farmer_eats/core/utils/validators.dart';
import 'package:farmer_eats/core/widgets/app_input_field.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupStep2Screen extends StatefulWidget {
  const SignupStep2Screen({super.key});

  @override
  State<SignupStep2Screen> createState() => _SignupStep2ScreenState();
}

class _SignupStep2ScreenState extends State<SignupStep2Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _informalNameController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  String? _selectedState;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.go('/signup/step1');
  }

  @override
  void initState() {
    super.initState();
    final SignupState signupState = context.read<SignupCubit>().state;
    _businessNameController.text = signupState.businessName;
    _informalNameController.text = signupState.informalName;
    _streetAddressController.text = signupState.address;
    _cityController.text = signupState.city;
    _zipController.text = signupState.zipCode;
    _selectedState = signupState.stateName.isEmpty
        ? null
        : signupState.stateName;
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _informalNameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
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
                    if ((_formKey.currentState?.validate() ?? false) &&
                        _selectedState != null) {
                      context.read<SignupCubit>().updateStep2(
                        businessName: _businessNameController.text.trim(),
                        informalName: _informalNameController.text.trim(),
                        address: _streetAddressController.text.trim(),
                        city: _cityController.text.trim(),
                        stateName: _selectedState!,
                        zipCode: _zipController.text.trim(),
                      );
                      context.go('/signup/step3');
                    } else if (_selectedState == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a state.')),
                      );
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
                  const Text('Signup 2 of 4', style: AppTextStyles.stepLabel),
                  const SizedBox(height: 6),
                  Image.asset(
                    AppAssets.progressDivider,
                    width: 120,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 8),
                  const Text('Farm Info', style: AppTextStyles.headline),
                  const SizedBox(height: 32),
                  AppInputField(
                    hintText: 'Business Name',
                    prefixAssetPath: AppAssets.iconLabel,
                    controller: _businessNameController,
                    validator: Validators.validateRequired,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Informal Name',
                    prefixAssetPath: AppAssets.iconSmiley,
                    controller: _informalNameController,
                    validator: Validators.validateRequired,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'Street Address',
                    prefixAssetPath: AppAssets.iconHome,
                    controller: _streetAddressController,
                    validator: Validators.validateRequired,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hintText: 'City',
                    prefixAssetPath: AppAssets.iconLocation,
                    controller: _cityController,
                    validator: Validators.validateRequired,
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final stateField = DropdownButtonFormField<String>(
                        // ignore: deprecated_member_use
                        value: _selectedState,
                        isExpanded: true,
                        icon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Image.asset(
                            AppAssets.iconDropdown,
                            width: 14,
                            height: 14,
                          ),
                        ),
                        items: usStates
                            .map(
                              (state) => DropdownMenuItem<String>(
                                value: state,
                                child: Text(
                                  state,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedState = value),
                        decoration: InputDecoration(
                          hintText: 'State',
                          iconColor: AppColors.textGrey,
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
                        ),
                      );

                      final zipField = AppInputField(
                        hintText: 'Enter Zipcode',
                        controller: _zipController,
                        keyboardType: TextInputType.number,
                        validator: Validators.validateZipCode,
                      );

                      if (constraints.maxWidth < 360) {
                        return Column(
                          children: [
                            stateField,
                            const SizedBox(height: 12),
                            zipField,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: stateField),
                          const SizedBox(width: 12),
                          Expanded(child: zipField),
                        ],
                      );
                    },
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
