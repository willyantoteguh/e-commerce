import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/base/auth/base_auth.dart';
import 'package:component/widget/base/onboarding/base_onboarding.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/presentasion/bloc/splash_bloc/splash_cubit.dart';
import 'package:onboarding/presentasion/bloc/splash_bloc/splash_state.dart';
import 'package:resources/assets.gen.dart';
import 'package:resources/colors.gen.dart';

class SplashScreen extends StatelessWidget with BaseAuth, BaseOnboarding {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        final status = state.splashState.status;
        if (status.isHasData) {
          if (state.splashState.data! == AppConstants.cachedKey.onBoardingKey) {
            toSignIn();
          }

          if (state.splashState.data! == AppConstants.cachedKey.tokenKey) {
            toHome();
          }
        }
        if (status.isNoData) {
          onboarding();
        }
      },
      child: Container(
        height: 1.sh,
        width: 1.sw,
        color: ColorName.orange,
        child: Center(
          child: Assets.images.logo.logo.svg(
            width: 147.w,
            height: 100.h,
          ),
        ),
      ),
    ));
  }
}
