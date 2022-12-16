import 'package:account/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:account/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:account/presentation/bloc/update_photo_bloc/update_photo_cubit.dart';
import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/ui/edit_profile_screen.dart';
import 'package:auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:auth/presentation/ui/sign_in_screen.dart';
import 'package:auth/presentation/ui/sign_up_screen.dart';
import 'package:cart_feature/presentation/bloc/cart_cubit.dart';
import 'package:cart_feature/presentation/ui/cart_screen.dart';
import 'package:common/utils/navigation/argument/detail_product/detail_product_argument.dart';
import 'package:common/utils/navigation/argument/payment/payment_argument.dart';
import 'package:common/utils/navigation/argument/payment/payment_va_argument.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';
import 'package:common/utils/setup_flavor/app_setup.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/product_detail_cubit.dart';
import 'package:detail_product/presentation/ui/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:home_page/presentation/bloc/banner_cubit/banner_cubit.dart';
import 'package:home_page/presentation/bloc/category_cubit/category_cubit.dart';
import 'package:home_page/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:home_page/presentation/bloc/product_cubit/product_cubit.dart';
import 'package:home_page/presentation/ui/bottom_navigation.dart';
import 'package:onboarding/presentasion/bloc/on_boarding_bloc/on_boarding_cubit.dart';
import 'package:onboarding/presentasion/bloc/splash_bloc/splash_cubit.dart';
import 'package:onboarding/presentasion/ui/on_boarding_screen.dart';
import 'package:onboarding/presentasion/ui/splash_screen.dart';
import 'package:payment_feature/presentation/bloc/history/history_cubit.dart';
import 'package:payment_feature/presentation/bloc/payment/payment_cubit.dart';
import 'package:payment_feature/presentation/ui/payment/payment_method_screen.dart';
import 'package:payment_feature/presentation/ui/payment/payment_screen.dart';
import 'package:payment_feature/presentation/ui/payment/payment_va_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(
        title: 'Flutter E Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: Config.isDebug,
        home: BlocProvider(
          create: (_) => SplashCubit(
            getOnBoardingStatusUsecase: sl(),
            getTokenUseCase: sl(),
          )..initSplash(),
          child: SplashScreen(),
        ),
        navigatorKey: NavigationHelperImpl.navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          final argument = settings.arguments;
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case AppRoutes.onboarding:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => OnBoardingCubit(cacheOnBoardingUseCase: sl()),
                  child: OnBoardingScreen(),
                ),
              );
            case AppRoutes.signIn:
              return MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => SignInBloc(
                          signInUseCase: sl(),
                          cacheTokenUseCase: sl(),
                        ),
                        child: SignInScreen(),
                      ));
            case AppRoutes.signUp:
              return MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => SignUpBloc(signUpUseCase: sl(), cacheTokenUseCase: sl()),
                        child: SignUpScreen(),
                      ));
            case AppRoutes.home:
              return MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(providers: [
                        BlocProvider<HomeCubit>(
                          create: (_) => HomeCubit(),
                        ),
                        BlocProvider<BannerCubit>(
                          create: (_) => BannerCubit(getBannerUseCase: sl())..getBanner(),
                        ),
                        BlocProvider<ProductCubit>(
                          create: (_) => ProductCubit(getProductUseCase: sl())..getProduct(),
                        ),
                        BlocProvider<CategoryCubit>(
                          create: (_) => CategoryCubit(getProductCategoryUseCase: sl())..getCategory(),
                        ),
                        BlocProvider<UserCubit>(
                          create: (_) => UserCubit(getUserUseCase: sl())..getUser(),
                        ),
                        BlocProvider<LogoutCubit>(
                          create: (_) => LogoutCubit(logoutUseCase: sl()),
                        ),
                        BlocProvider<HistoryCubit>(
                          create: (_) => HistoryCubit(getHistoryUseCase: sl()),
                        ),
                      ], child: const BottomNavigation()));
            case AppRoutes.editProfile:
              return MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider<UserCubit>(
                            create: (_) => UserCubit(getUserUseCase: sl())..getUser(),
                          ),
                          BlocProvider<EditProfileBloc>(
                            create: (_) => EditProfileBloc(
                              updateUserUseCase: sl(),
                              firebaseMessaging: sl(),
                            ),
                          ),
                          BlocProvider<UpdatePhotoCubit>(
                            create: (_) => UpdatePhotoCubit(
                              imagePicker: sl(),
                              uploadPhotoUseCase: sl(),
                            ),
                          ),
                        ],
                        child: EditProfileScreen(),
                      ));
            case AppRoutes.detailProduct:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<ProductDetailCubit>(
                  create: (_) => ProductDetailCubit(
                    getProductDetailUseCase: sl(),
                    getSellerUseCase: sl(),
                    addToChartUseCase: sl(),
                    saveProductUseCase: sl(),
                    deleteProductUseCase: sl(),
                    getFavoriteProductByUrlUseCase: sl(),
                  ),
                  child: DetailProductScreen(
                    argument: argument as DetailProductArgument,
                  ),
                ),
              );
            case AppRoutes.cartList:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<CartCubit>(
                  create: (_) => CartCubit(
                    getChartUseCase: sl(),
                    addToChartUseCase: sl(),
                    deleteChartUseCase: sl(),
                  ),
                  child: const CartScreen(),
                ),
              );
            case AppRoutes.payment:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<PaymentCubit>(
                  create: (_) => PaymentCubit(
                    getAllPaymentMethodUseCase: sl(),
                    createTransactionUseCase: sl(),
                  ),
                  child: PaymentScreen(argument: argument as PaymentArgument),
                ),
              );
            case AppRoutes.paymentMethod:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<PaymentCubit>(
                  create: (_) => PaymentCubit(
                    getAllPaymentMethodUseCase: sl(),
                    createTransactionUseCase: sl(),
                  ),
                  child: const PaymentMethodScreen(),
                ),
              );
            case AppRoutes.paymentVa:
              return MaterialPageRoute(
                builder: (_) => PaymentVAScreen(
                  argument: argument as PaymentVAArgument,
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => SplashScreen());
          }
        },
      ),
    );
  }
}
