import 'package:farmer_eats/core/storage/secure_storage.dart';
import 'package:farmer_eats/features/auth/domain/usecases/login_usecase.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(const LoginState());

  final LoginUseCase _loginUseCase;

  Future<void> login({
    required String email,
    required String password,
    String type = 'email',
    String? socialId,
  }) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));
    try {
      final token = await _loginUseCase(
        email: email,
        password: password,
        type: type,
        socialId: socialId,
      );

      if (token.isEmpty) {
        throw Exception('Authentication token was not returned.');
      }

      await SecureStorage.setToken(token);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
