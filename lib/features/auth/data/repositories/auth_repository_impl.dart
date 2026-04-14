import 'package:farmer_eats/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:farmer_eats/features/auth/data/models/login_request_model.dart';
import 'package:farmer_eats/features/auth/data/models/register_request_model.dart';
import 'package:farmer_eats/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmer_eats/injection.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDatasource);

  final AuthRemoteDatasource _remoteDatasource;

  @override
  Future<String> login({
    required String email,
    required String password,
    String type = 'email',
    String? socialId,
    String deviceToken = kDeviceToken,
  }) async {
    final response = await _remoteDatasource.login(
      LoginRequestModel(
        email: email,
        password: password,
        type: type,
        socialId: socialId,
        deviceToken: deviceToken,
      ),
    );
    return response.token ?? '';
  }

  @override
  Future<String> register(RegisterRequestModel request) async {
    final response = await _remoteDatasource.register(request);
    return response.token ?? '';
  }

  @override
  Future<void> forgotPassword(String mobile) {
    return _remoteDatasource.forgotPassword(mobile);
  }

  @override
  Future<String> verifyOtp(String otp) {
    return _remoteDatasource.verifyOtp(otp);
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  }) {
    return _remoteDatasource.resetPassword(
      token: token,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
