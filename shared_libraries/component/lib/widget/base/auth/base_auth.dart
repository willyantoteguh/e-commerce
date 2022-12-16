import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseAuth {
  final AuthRouter _authRouter = sl();

  AuthRouter get authRouter => _authRouter;

  void toHome() => authRouter.navigateToHome();
  void toSignIn() => authRouter.navigateToSignIn();
  void toSignUp() => authRouter.navigateToSignUp();
  void back({String? arguments}) => authRouter.goBack(arguments: arguments);
}
