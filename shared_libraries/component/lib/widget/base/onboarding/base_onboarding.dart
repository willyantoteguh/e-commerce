import 'package:common/utils/navigation/router/onboarding_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseOnboarding {
  final OnboardingRouter _onboardingRouter = sl();

  OnboardingRouter get onBoardingRouter => _onboardingRouter;

  void onboarding() => onBoardingRouter.navigateToOnboarding();
}
