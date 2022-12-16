import 'dart:developer';

import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/card/history_card.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:payment/domain/entity/response/product_history_entity.dart';
import 'package:payment_feature/presentation/bloc/history/history_cubit.dart';
import 'package:payment_feature/presentation/bloc/history/history_state.dart';
import 'package:resources/colors.gen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void _loadHistory(BuildContext context) => context.read<HistoryCubit>().getHistory();

  @override
  void initState() {
    super.initState();
    _loadHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          backgroundColor: ColorName.white,
          elevation: 0.0,
          title: Container(
            alignment: Alignment.centerLeft,
            height: 35.h,
            child: Text(
              "Riwayat Belanja",
              style: TextStyle(
                color: ColorName.orange,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: ColorName.orange),
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(builder: (context, state) {
          final status = state.historyState.status;
          if (state.historyState.status.isLoading) {
            return const CustomCircularProgressIndicator();
          } else if (state.historyState.status.isError) {
            log('ERROR');
            return Text(state.historyState.message);
          } else if (state.historyState.status.isNoData) {
            log('NO DATA');
            return Text(state.historyState.message);
          } else if (state.historyState.status.isHasData) {
            log('HAS DATA');
            final listHistory = state.historyState.data?.data ?? <DataHistoryEntity>[];

            return ListView.builder(
              shrinkWrap: true,
              itemCount: listHistory.length,
              itemBuilder: (context, index) {
                final itemHistory = listHistory[index];
                // final  product;

                final productLength = itemHistory.productData.length;

                int totalProduct = 0;
                if (productLength > 1) {
                  totalProduct = productLength - 1;
                } else {
                  totalProduct = productLength;
                }

                String productImgUrl = '';
                String productName = '';
                try {
                  // for (var e in itemHistory.productData) {
                  //   List<>
                  // }
                  productImgUrl = itemHistory.productData.first.product.imageUrl;
                  productName = itemHistory.productData.first.product.name;
                  log("Cek img: $productImgUrl");
                } catch (e) {
                  log(e.toString());
                }

                return HistoryCard(
                  statusPayment: itemHistory.paymentTransaction.statusPayment,
                  createdAt: itemHistory.createdAt,
                  // productUrl: "https://aurel-store.herokuapp.com/image/tono_b0d221d0-222c-429e-8ad7-e616c3e61e78.jpg",
                  productUrl: productImgUrl,
                  productName: productName,
                  // productName: productData.product.name,
                  totalProduct: totalProduct,
                  // totalProduct: itemHistory.productData.first.quantity,
                  productPrice: itemHistory.amount,
                );
                // return Text('....');
              },
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}
