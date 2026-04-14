import 'dart:io';

import 'package:farmer_eats/injection.dart';

class RegisterRequestModel {
  RegisterRequestModel({
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
    required this.businessHours,
    this.registrationProof,
    this.role = 'farmer',
    this.deviceToken = kDeviceToken,
    this.type = 'email',
    this.socialId,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final File? registrationProof;
  final Map<String, List<String>> businessHours;
  final String deviceToken;
  final String type;
  final String? socialId;
}
