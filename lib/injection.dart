import 'package:farmer_eats/core/network/api_client.dart';
import 'package:farmer_eats/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:farmer_eats/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:farmer_eats/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmer_eats/features/auth/domain/usecases/login_usecase.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/login_cubit.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
const String kDeviceToken = 'device_token';

Future<void> setupDependencies() async {
  if (!getIt.isRegistered<ApiClient>()) {
    getIt.registerLazySingleton<ApiClient>(ApiClient.new);
  }
  if (!getIt.isRegistered<AuthRemoteDatasource>()) {
    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(getIt<ApiClient>()),
    );
  }
  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteDatasource>()),
    );
  }
  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<SignupCubit>()) {
    getIt.registerLazySingleton<SignupCubit>(
      () => SignupCubit(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUseCase>()));
  }
}
