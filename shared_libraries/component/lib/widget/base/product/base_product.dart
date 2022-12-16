import 'package:common/utils/navigation/router/product_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseProduct {
  final _productRouter = sl<ProductRouter>();

  ProductRouter get productRouter => _productRouter;

  void toCart() => productRouter.navigateToCartList();
}
