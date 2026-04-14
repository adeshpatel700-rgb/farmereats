import 'package:farmer_eats/features/auth/data/models/register_request_model.dart';

abstract class AuthRepository {
  Future<String> login({
    required String email,
    required String password,
    String type,
    String? socialId,
    String deviceToken,
  });

  Future<String> register(RegisterRequestModel request);

  Future<void> forgotPassword(String mobile);

  Future<String> verifyOtp(String otp);

  Future<void> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  });
}
