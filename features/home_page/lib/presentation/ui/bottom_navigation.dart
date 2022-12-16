import 'package:account/presentation/ui/account_screen.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home_page/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:home_page/presentation/ui/home_screen.dart';
import 'package:payment_feature/presentation/ui/history/history_screen.dart';
import 'package:resources/assets.gen.dart';
import 'package:resources/colors.gen.dart';

import '../bloc/home_cubit/home_state.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: IndexedStack(
            index: context.read<HomeCubit>().state.homeState.data,
            children: [
              HomeScreen(),
              const HistoryScreen(),
              AccountScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ]),
          child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: context.read<HomeCubit>().state.homeState.data ?? 0,
              onTap: (value) {
                context.read<HomeCubit>().changeTab(tabIndex: value);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorName.orange,
              unselectedItemColor: ColorName.iconGrey,
              selectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: ColorName.orange,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: ColorName.iconGrey,
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Assets.images.icon.home.svg(color: (context.read<HomeCubit>().state.homeState.data == 0) ? ColorName.orange : ColorName.iconGrey), label: 'Beranda'),
                BottomNavigationBarItem(icon: Assets.images.icon.history.svg(color: (context.read<HomeCubit>().state.homeState.data == 1) ? ColorName.orange : ColorName.iconGrey), label: 'Riwayat'),
                BottomNavigationBarItem(icon: Assets.images.icon.account.svg(color: (context.read<HomeCubit>().state.homeState.data == 2) ? ColorName.orange : ColorName.iconGrey), label: 'Akun'),
              ]),
        ),
      );
    });
  }
}
