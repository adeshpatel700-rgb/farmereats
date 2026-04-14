import 'package:farmer_eats/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmer_eats/injection.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<String> call({
    required String email,
    required String password,
    String type = 'email',
    String? socialId,
    String deviceToken = kDeviceToken,
  }) {
    return _repository.login(
      email: email,
      password: password,
      type: type,
      socialId: socialId,
      deviceToken: deviceToken,
    );
  }
}
