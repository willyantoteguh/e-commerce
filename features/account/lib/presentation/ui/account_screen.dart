import 'package:account/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:account/presentation/bloc/logout_bloc/logout_state.dart';
import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/bloc/user_bloc/user_state.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/base/base_navigator.dart';
import 'package:component/widget/button/chevron_button.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

class AccountScreen extends StatelessWidget with BaseAuth, BaseHome {
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.textFieldBackgroundGrey,
      appBar: AppBar(
        backgroundColor: ColorName.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Akun Saya",
          style: TextStyle(
            color: ColorName.orange,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<LogoutCubit, LogoutState>(listener: (context, state) {
        final status = state.logoutState.status;

        if (status.isHasData) {
          toSignIn();
        }
      }, builder: (context, state) {
        final status = state.logoutState.status;

        return LoadingStack(
          isLoading: status.isLoading,
          widget: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    final status = state.userState.status;

                    if (status.isLoading) {
                      return const Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    } else if (status.isHasData) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(45.0)),
                            child: CachedNetworkImage(
                              height: 40.w,
                              width: 40.w,
                              imageUrl: state.userState.data!.imageUrl,
                              placeholder: (context, url) => const Center(
                                child: CustomCircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            state.userState.data!.fullName.isEmpty ? state.userState.data!.username : state.userState.data!.fullName,
                            style: TextStyle(
                              color: ColorName.textBlack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    } else if (status.isError) {
                      return Center(
                        child: Text(state.userState.message),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                ChevronButton(
                  buttonText: 'Data Diri',
                  onTap: () async {
                    await toEditProfile()?.then((value) {
                      if (value == 'update') {
                        context.read<UserCubit>().getUser();
                      }
                    });
                  },
                ),
                ChevronButton(
                  buttonText: 'Logout',
                  onTap: () => context.read<LogoutCubit>().logout(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
