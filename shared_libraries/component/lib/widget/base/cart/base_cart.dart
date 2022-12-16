import 'package:common/utils/navigation/router/cart_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseCart {
  final _cartRouter = sl<CartRouter>();

  CartRouter get cartRouter => _cartRouter;

  void toPayment(int totalAmount) => cartRouter.navigateToPayment(totalAmount);
}
