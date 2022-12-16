import 'package:common/utils/setup_flavor/app_setup.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/app/main_app.dart';

import '../injections/injections.dart';

void main() async {
  Config.appFlavor = Flavor.production;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections().initialize();
  runApp(const MainApp());
}
