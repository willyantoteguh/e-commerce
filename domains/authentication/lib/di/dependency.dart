import 'package:authentication/data/datasource/local/authentication_local_datasource.dart';
import 'package:authentication/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/data/repository/authentication_repository_impl.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:authentication/domain/usecases/cache_onboarding_usecases.dart';
import 'package:authentication/domain/usecases/cache_token_usecase.dart';
import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:authentication/domain/usecases/get_token_usecase.dart';
import 'package:authentication/domain/usecases/logout_usecase.dart';
import 'package:authentication/domain/usecases/sign_up_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

import '../domain/usecases/sign_in_usecase.dart';

class AuthenticationDependency {
  AuthenticationDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    );
    sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(
        dio: sl(),
      ),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<AuthenticationMapper>(
      () => AuthenticationMapper(),
    );
  }

  void _registerRepository() {
    sl.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(
        authenticationLocalDataSource: sl(),
        authenticationRemoteDataSource: sl(),
        mapper: sl(),
      ),
    );
  }

  void _registerUseCase() {
    sl.registerLazySingleton<CacheOnBoardingUseCase>(
      () => CacheOnBoardingUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetOnBoardingStatusUsecase>(
      () => GetOnBoardingStatusUsecase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<CacheTokenUseCase>(
      () => CacheTokenUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetTokenUseCase>(
      () => GetTokenUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        authenticationRepository: sl(),
      ),
    );
  }
}
