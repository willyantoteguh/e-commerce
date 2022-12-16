import 'package:cart/domain/entity/request/add_to_chart_entity.dart';
import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/argument/detail_product/detail_product_argument.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/appbar/custom_appbar.dart';
import 'package:component/widget/base/base_navigator.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/button/payment_button.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/bloc.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/product_detail_cubit.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:resources/colors.gen.dart';
import 'package:dependencies/html/html.dart';

class DetailProductScreen extends StatefulWidget {
  final DetailProductArgument argument;

  const DetailProductScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> with BaseProduct {
  void _closeBottomSheet(BuildContext context) => Navigator.pop(context);

  @override
  void initState() {
    super.initState();
    _getProductDetail();
    _getProductFavorite(widget.argument.imageUrl);
  }

  void _getProductDetail() {
    context.read<ProductDetailCubit>().getProduct(widget.argument.productId);
  }

  void _addProductToChart(AddToChartEntity body) {
    context.read<ProductDetailCubit>().addToChart(body);
  }

  void _saveProductFavorite(ProductDetailDataEntity data) {
    context.read<ProductDetailCubit>().saveProductFavorite(data);
  }

  void _getProductFavorite(String imageUrl) {
    context.read<ProductDetailCubit>().getProductFavorite(imageUrl);
  }

  void _deleteProductFavorite(String imageUrl) {
    context.read<ProductDetailCubit>().deleteProduct(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: CustomAppBar(onPressed: () => toCart()),
      body: Center(
        child: BlocConsumer<ProductDetailCubit, ProductDetailState>(
          listener: (context, state) {
            final chartState = state.addToChartState.status;
            if (chartState.isError) {
              CustomToast.showErrorToast(
                errorMessage: state.addToChartState.failure!.errorMessage,
              );
            } else if (chartState.isHasData) {
              _showSuccessAddToChart(state.addToChartState.data!);
            }
          },
          builder: (context, state) {
            final productState = state.productState.status;
            final chartState = state.addToChartState.status;
            if (productState.isLoading) {
              return const CustomCircularProgressIndicator();
            } else if (productState.isError) {
              return Text(state.productState.failure!.errorMessage);
            } else if (productState.isHasData) {
              final productData = state.productState.data ?? const ProductDetailDataEntity();
              return LoadingStack(
                isLoading: chartState.isLoading,
                widget: Stack(
                  children: [
                    ListView(
                      children: [
                        CachedNetworkImage(
                          imageUrl: productData.imageUrl,
                          fit: BoxFit.contain,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 10.h,
                            bottom: 40.h,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      productData.price.toIDR(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: ColorName.textDarkGrey,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<ProductDetailCubit, ProductDetailState>(builder: (context, state) {
                                    final isFavorite = state.isFavorite;

                                    return InkWell(
                                      onTap: () {
                                        if (isFavorite) {
                                          _deleteProductFavorite(productData.imageUrl);
                                        } else {
                                          _saveProductFavorite(productData);
                                        }
                                      },
                                      child: Icon(
                                        isFavorite ? Icons.star : Icons.star_border,
                                        color: ColorName.orange,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                productData.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: ColorName.textDarkGrey,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "${productData.soldCount}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  color: ColorName.textDarkGrey,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              const _Seller(),
                              SizedBox(height: 20.h),
                              Text(
                                "Informasi Produk",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                  color: ColorName.textDarkGrey,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Text(
                                    "Kategori",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: ColorName.textDarkGrey,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    productData.category.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: ColorName.orange,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 23.h),
                              Container(
                                color: ColorName.textFieldBackgroundGrey,
                                width: double.infinity,
                                height: 1.h,
                              ),
                              SizedBox(height: 19.h),
                              Text(
                                "Deskripsi Produk",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                  color: ColorName.textDarkGrey,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              HtmlWidget(
                                productData.description,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  color: ColorName.textDarkGrey,
                                ),
                              ),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                    PaymentButton(
                      addToCart: chartState.isLoading
                          ? null
                          : () => _addProductToChart(
                                AddToChartEntity(
                                  productId: productData.id,
                                  amount: 1,
                                  productName: productData.name,
                                  description: productData.description,
                                  imageUrl: productData.imageUrl,
                                ),
                              ),
                      payment: chartState.isLoading ? null : () {},
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  void _showSuccessAddToChart(AddToChartEntity data) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => _closeBottomSheet(context),
                  child: const Icon(Icons.close, color: ColorName.orange),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            child: CachedNetworkImage(
                              height: 54.h,
                              width: 69.w,
                              imageUrl: data.imageUrl,
                              placeholder: (context, url) => const Center(child: CustomCircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 9.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.sp,
                                    color: ColorName.textDarkGrey,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                HtmlWidget(
                                  data.description,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8.sp,
                                    color: ColorName.textDarkGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      CustomButton(
                        buttonText: "Lihat Keranjang",
                        onTap: () => toCart(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Seller extends StatelessWidget {
  const _Seller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          final sellerState = state.sellerState.status;
          if (sellerState.isLoading) {
            return const CustomCircularProgressIndicator();
          } else if (sellerState.isError) {
            return Text(state.sellerState.failure!.errorMessage);
          } else if (sellerState.isHasData) {
            final sellerDetail = state.sellerState.data ?? const SellerDataEntity();
            return Column(
              children: [
                Container(
                  color: ColorName.textFieldBackgroundGrey,
                  width: double.infinity,
                  height: 1.h,
                ),
                SizedBox(height: 13.h),
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: sellerDetail.imageUrl,
                        height: 40.w,
                        width: 40.w,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sellerDetail.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            color: ColorName.textDarkGrey,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          sellerDetail.city,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: ColorName.textDarkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 13.h),
                Container(
                  color: ColorName.textFieldBackgroundGrey,
                  width: double.infinity,
                  height: 1.h,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
