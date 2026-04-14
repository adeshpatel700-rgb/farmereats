import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/widgets/app_day_chip.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:farmer_eats/core/widgets/app_time_slot_chip.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupStep4Screen extends StatefulWidget {
  const SignupStep4Screen({super.key});

  @override
  State<SignupStep4Screen> createState() => _SignupStep4ScreenState();
}

class _SignupStep4ScreenState extends State<SignupStep4Screen> {
  static const Map<String, String> dayKeyMap = {
    'M': 'mon',
    'T': 'tue',
    'W': 'wed',
    'Th': 'thu',
    'F': 'fri',
    'S': 'sat',
    'Su': 'sun',
  };

  static const List<String> slots = [
    '8:00am - 10:00am',
    '10:00am - 1:00pm',
    '1:00pm - 4:00pm',
    '4:00pm - 7:00pm',
    '7:00pm - 10:00pm',
  ];

  String _activeDayLabel = 'M';

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.go('/signup/step3');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        if (state.status == SignupStatus.success) {
          context.go('/confirmation');
        }
      },
      builder: (context, state) {
        final String activeKey = dayKeyMap[_activeDayLabel] ?? 'mon';
        final List<String> selectedSlots =
            state.businessHours[activeKey] ?? <String>[];

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
                    icon: Image.asset(
                      AppAssets.iconBack,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 180,
                    child: AppPrimaryButton(
                      label: 'Signup',
                      isLoading: state.status == SignupStatus.loading,
                      onPressed: () =>
                          context.read<SignupCubit>().submitRegistration(),
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
                    const Text('Signup 4 of 4', style: AppTextStyles.stepLabel),
                    const SizedBox(height: 6),
                    Image.asset(
                      AppAssets.progressDivider,
                      width: 120,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 8),
                    const Text('Business Hours', style: AppTextStyles.headline),
                    const SizedBox(height: 12),
                    const Text(
                      'Choose the hours your farm is open for pickups. This will allow customers to order deliveries.',
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: dayKeyMap.keys
                          .map(
                            (label) => AppDayChip(
                              label: label,
                              selected: _activeDayLabel == label,
                              onTap: () =>
                                  setState(() => _activeDayLabel = label),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      itemCount: slots.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.45,
                          ),
                      itemBuilder: (context, index) {
                        final slot = slots[index];
                        return AppTimeSlotChip(
                          label: slot,
                          selected: selectedSlots.contains(slot),
                          onTap: () {
                            context.read<SignupCubit>().toggleBusinessHourSlot(
                              day: activeKey,
                              slot: slot,
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
