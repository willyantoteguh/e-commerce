import 'package:common/utils/navigation/argument/detail_product/detail_product_argument.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/appbar/custom_appbar.dart';
import 'package:component/widget/base/base_navigator.dart';
import 'package:component/widget/card/banner_card.dart';
import 'package:component/widget/card/product_card.dart';
import 'package:component/widget/card/product_category_card.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home_page/presentation/bloc/banner_cubit/banner_cubit.dart';
import 'package:home_page/presentation/bloc/category_cubit/category_cubit.dart';
import 'package:home_page/presentation/bloc/category_cubit/category_state.dart';
import 'package:resources/colors.gen.dart';

import '../bloc/banner_cubit/banner_cubit.dart';
import '../bloc/banner_cubit/banner_state.dart';
import '../bloc/product_cubit/product_cubit.dart';
import '../bloc/product_cubit/product_state.dart';

class HomeScreen extends StatelessWidget with BaseHome {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: CustomAppBar(
        onPressed: () => toCart(),
      ),
      body: ListView(
        children: [
          Container(
            height: 145.h,
            width: 325.w,
            margin: const EdgeInsets.only(left: 8, top: 8),
            child: BlocBuilder<BannerCubit, BannerState>(
              builder: (context, state) {
                final status = state.bannerState.status;

                if (status.isLoading) {
                  return const Center(
                    child: CustomCircularProgressIndicator(),
                  );
                } else if (status.isHasData) {
                  final banners = state.bannerState.data ?? [];

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        return BannerCard(bannerDataEntity: banners[index]);
                      });
                } else if (status.isError) {
                  return Center(child: Text(state.bannerState.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h, bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Produk Terkait',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorName.textBlack,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorName.orange,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 195.h,
            margin: const EdgeInsets.only(
              left: 8,
            ),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final status = state.productState.status;

                if (status.isLoading) {
                  return const Center(
                    child: CustomCircularProgressIndicator(),
                  );
                } else if (status.isHasData) {
                  final products = state.productState.data?.data ?? [];

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final productId = product.id;
                        final imageUrl = product.imageUrl;

                        return ProductCard(
                            productEntity: product,
                            onPressed: () => toProductDetail(DetailProductArgument(
                                  productId: productId,
                                  imageUrl: imageUrl,
                                )));
                      });
                } else if (status.isError) {
                  return Center(child: Text(state.productState.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 27.h, bottom: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kategori Pilihan",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorName.textBlack,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Lihat semua",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorName.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
            final status = state.categoryState.status;
            if (status.isLoading) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (status.isHasData) {
              final category = state.categoryState.data ?? [];
              final categoryLength = category.length > 3 ? 3 : category.length;

              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: categoryLength,
                  itemBuilder: (_, index) {
                    return ProductCategoryCard(
                      productCategoryEntity: category[index],
                    );
                  });
            } else if (status.isError) {
              return Center(
                child: Text(state.categoryState.message),
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
