import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'signup_confirmation_screen.dart';

class SignupHoursScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String? registrationProof;

  const SignupHoursScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.registrationProof,
  });

  @override
  State<SignupHoursScreen> createState() => _SignupHoursScreenState();
}

class _SignupHoursScreenState extends State<SignupHoursScreen> {
  final List<String> _daysOfWeek = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'];
  final List<bool> _selectedDays = List.filled(7, false);
  final List<TimeSlot> _timeSlots = [];
  bool _isLoading = false;

  void _addTimeSlot() {
    setState(() {
      _timeSlots.add(TimeSlot(startTime: '8:00am', endTime: '10:00am'));
    });
  }

  void _removeTimeSlot(int index) {
    setState(() {
      _timeSlots.removeAt(index);
    });
  }

  Map<String, dynamic> _buildBusinessHours() {
    final Map<String, dynamic> hours = {};
    final selectedDayNames = [];

    for (int i = 0; i < _selectedDays.length; i++) {
      if (_selectedDays[i]) {
        selectedDayNames.add(_daysOfWeek[i]);
      }
    }

    for (var slot in _timeSlots) {
      for (var day in selectedDayNames) {
        hours[day] = '${slot.startTime} - ${slot.endTime}';
      }
    }

    return hours;
  }

  Future<void> _handleSignup() async {
    if (_timeSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one time slot')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final request = RegisterRequest(
      fullName: widget.fullName,
      email: widget.email,
      phone: widget.phone,
      password: widget.password,
      businessName: widget.businessName,
      informalName: widget.informalName,
      address: widget.address,
      city: widget.city,
      state: widget.state,
      zipCode: widget.zipCode,
      registrationProof: widget.registrationProof,
      businessHours: _buildBusinessHours(),
    );

    final result = await ApiService.register(request);

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (result['success']) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupConfirmationScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['error'] ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FarmerEats',
                style: TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
              const SizedBox(height: 60),
              const Text(
                'Signup 4 of 4',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Business Hours',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Choose the hours your farm is open for pickups. This will allow customers to order deliveries.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDays[index] = !_selectedDays[index];
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedDays[index]
                            ? AppColors.primaryGreen
                            : AppColors.cardBackground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedDays[index]
                              ? AppColors.primaryGreen
                              : AppColors.textGrey.withOpacity(0.3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _daysOfWeek[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _selectedDays[index]
                                ? Colors.white
                                : AppColors.textDark,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              ..._timeSlots.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryYellow.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            entry.value.startTime,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryYellow.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            entry.value.endTime,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeTimeSlot(entry.key),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: _addTimeSlot,
                icon: const Icon(Icons.add, color: AppColors.textDark),
                label: const Text(
                  'Add time slot',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textDark,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBackgroundColor: AppColors.primaryGreen
                          .withOpacity(0.5),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSlot {
  String startTime;
  String endTime;

  TimeSlot({required this.startTime, required this.endTime});
}
