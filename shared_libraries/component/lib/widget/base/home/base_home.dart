import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/navigation/router/home_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseHome {
  final HomeRouter _homeRouter = sl();

  HomeRouter get homeRouter => _homeRouter;

  void toProductDetail(DetailProductArgument argument) => homeRouter.navigateToDetailProduct(argument);
  void toCart() => homeRouter.navigateToCartList();
  Future<dynamic>? toEditProfile() => homeRouter.navigateToEditProfile();
}
