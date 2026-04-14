import 'package:farmer_eats/injection.dart';

class LoginRequestModel {
  LoginRequestModel({
    required this.email,
    required this.password,
    this.role = 'farmer',
    this.deviceToken = kDeviceToken,
    this.type = 'email',
    this.socialId,
  });

  final String email;
  final String password;
  final String role;
  final String deviceToken;
  final String type;
  final String? socialId;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'device_token': deviceToken,
      'type': type,
      if (socialId != null && socialId!.isNotEmpty) 'social_id': socialId,
    };
  }
}
