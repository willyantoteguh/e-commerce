import 'dart:developer';

import 'package:common/utils/constants/app_constants.dart';

enum Flavor {
  development,
  production,
}

class Config {
  static Config? _instance;

  Config._internal() {
    _instance = this;
  }

  factory Config() => _instance ?? Config._internal();

  static Flavor? appFlavor;

  static bool get isDebug {
    if (appFlavor == Flavor.production) {
      return false;
    } else {
      return true;
    }
  }

  static String get baseUrl {
    if (appFlavor == Flavor.production) {
      log('ENV: PRODUCTION');
      return AppConstants.appApi.baseUrlProd;
    } else {
      log('ENV: DEVELOPMENT');
      return AppConstants.appApi.baseUrlDev;
    }
  }
}
