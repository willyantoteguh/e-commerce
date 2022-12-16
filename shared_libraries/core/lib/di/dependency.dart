import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/setup_flavor/app_setup.dart';
import 'package:core/network/dio_handler.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/get_it/get_it.dart';

import '../local/database/database_module.dart';

class RegisterCoreModule {
  RegisterCoreModule() {
    _registerCore();
  }

  void _registerCore() {
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
    sl.registerLazySingleton<DioHandler>(() => DioHandler(
          sharedPreferences: sl(),
          apiBaseUrl: Config.baseUrl,
        ));

    sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  }
}
