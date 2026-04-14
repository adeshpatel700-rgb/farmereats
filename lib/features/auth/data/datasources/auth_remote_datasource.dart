import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmer_eats/core/network/api_client.dart';
import 'package:farmer_eats/core/network/api_constants.dart';
import 'package:farmer_eats/features/auth/data/models/login_request_model.dart';
import 'package:farmer_eats/features/auth/data/models/login_response_model.dart';
import 'package:farmer_eats/features/auth/data/models/register_request_model.dart';
import 'package:farmer_eats/features/auth/data/models/register_response_model.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _apiClient.post(
      ApiConstants.login,
      data: request.toJson(),
      options: Options(headers: const {'Content-Type': 'application/json'}),
    );
    final data = Map<String, dynamic>.from(response.data as Map);

    if (!_isSuccess(data['success'])) {
      throw ApiException(_message(data));
    }

    return LoginResponseModel.fromJson(data);
  }

  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final formData = FormData.fromMap({
      'full_name': request.fullName,
      'email': request.email,
      'phone': request.phone,
      'password': request.password,
      'role': request.role,
      'business_name': request.businessName,
      'informal_name': request.informalName,
      'address': request.address,
      'city': request.city,
      'state': request.state,
      'zip_code': int.tryParse(request.zipCode) ?? request.zipCode,
      'business_hours': jsonEncode(request.businessHours),
      'device_token': request.deviceToken,
      'type': request.type,
      if (request.socialId != null && request.socialId!.isNotEmpty)
        'social_id': request.socialId,
      if (request.registrationProof != null)
        'registration_proof': await MultipartFile.fromFile(
          request.registrationProof!.path,
          filename: request.registrationProof!.path
              .split(RegExp(r'[\\/]'))
              .last,
        ),
    });

    final response = await _apiClient.post(
      ApiConstants.register,
      data: formData,
    );
    final data = Map<String, dynamic>.from(response.data as Map);

    if (!_isSuccess(data['success'])) {
      throw ApiException(_message(data));
    }

    return RegisterResponseModel.fromJson(data);
  }

  Future<void> forgotPassword(String mobile) async {
    final response = await _apiClient.post(
      ApiConstants.forgotPassword,
      data: {'mobile': mobile},
    );
    final data = Map<String, dynamic>.from(response.data as Map);
    if (!_isSuccess(data['success'])) {
      throw ApiException(_message(data));
    }
  }

  Future<String> verifyOtp(String otp) async {
    final response = await _apiClient.post(
      ApiConstants.verifyOtp,
      data: {'otp': otp},
    );
    final data = Map<String, dynamic>.from(response.data as Map);
    if (!_isSuccess(data['success'])) {
      throw ApiException(_message(data));
    }
    return data['token']?.toString() ?? '';
  }

  Future<void> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.resetPassword,
      data: {
        'token': token,
        'password': password,
        'cpassword': confirmPassword,
      },
    );
    final data = Map<String, dynamic>.from(response.data as Map);
    if (!_isSuccess(data['success'])) {
      throw ApiException(_message(data));
    }
  }

  bool _isSuccess(dynamic successValue) => successValue?.toString() == 'true';

  String _message(Map<String, dynamic> data) {
    return data['message']?.toString() ?? 'Something went wrong.';
  }
}
