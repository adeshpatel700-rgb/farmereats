import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../models/user_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('${AppStrings.baseUrl}/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      return {
        'success': response.statusCode == 200,
        'data': jsonDecode(response.body),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('${AppStrings.baseUrl}/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      return {
        'success': response.statusCode == 200,
        'data': jsonDecode(response.body),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${AppStrings.baseUrl}/user/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      return {
        'success': response.statusCode == 200,
        'data': jsonDecode(response.body),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${AppStrings.baseUrl}/user/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      return {
        'success': response.statusCode == 200,
        'data': jsonDecode(response.body),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${AppStrings.baseUrl}/user/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      return {
        'success': response.statusCode == 200,
        'data': jsonDecode(response.body),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
