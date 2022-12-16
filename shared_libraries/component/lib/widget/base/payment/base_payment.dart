import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/navigation/router/payment_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BasePayment {
  final _paymentRouter = sl<PaymentRouter>();

  PaymentRouter get paymentRouter => _paymentRouter;

  Future<dynamic>? toPaymentMethod() => paymentRouter.navigateToPaymentMethod();
  void selectPayment(PaymentMethodArgument argument) => paymentRouter.selectPayment(argument);
  Future<dynamic>? toPaymentVA(PaymentVAArgument argument) => paymentRouter.navigateToPaymentMethod();
  void toHome() => paymentRouter.navigateToHome();
}
