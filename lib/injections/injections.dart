import 'package:common/utils/di/common_dependencies.dart';
import 'package:core/di/dependency.dart';
import 'package:dependencies/di/dependency.dart';
import 'package:authentication/di/dependency.dart';
import 'package:payment/di/dependency.dart';
import 'package:product/di/dependency.dart';
import 'package:profile/di/dependency.dart';
import 'package:cart/di/dependency.dart';

class Injections {
  Future<void> initialize() async {
    await _registerSharedDependencies();
    _registerDomains();
  }

  void _registerDomains() {
    AuthenticationDependency();
    ProductDependency();
    ProfileDependency();
    ChartDependency();
    PaymentDependency();
  }

  Future<void> _registerSharedDependencies() async {
    await const SharedLibDependencies().registerCore();
    RegisterCoreModule();
    CommonDependencies();
  }
}
