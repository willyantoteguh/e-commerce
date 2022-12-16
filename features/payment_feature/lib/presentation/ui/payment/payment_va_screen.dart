import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/argument/payment/payment_va_argument.dart';
import 'package:component/widget/base/base_navigator.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/divider/custom_divider.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resources/colors.gen.dart';

class PaymentVAScreen extends StatelessWidget with BasePayment {
  final PaymentVAArgument argument;

  PaymentVAScreen({Key? key, required this.argument}) : super(key: key);

  void backToHome() => toHome();

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
            'Selesaikan Pembayaran',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorName.orange,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: ColorName.orange),
      ),
      body: Center(
        child: Column(
          children: [
            const CustomDivider(),
            Expanded(child: SummaryWidget(argument: argument)),
            Container(
              margin: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
              width: double.infinity,
              child: CustomButton(
                buttonColor: ColorName.orange,
                buttonText: 'Selesaikan Pembayaran',
                onTap: () => backToHome(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SummaryWidget extends StatelessWidget {
  final PaymentVAArgument argument;

  const SummaryWidget({Key? key, required this.argument}) : super(key: key);

  Future<void> _copyToClipboard(BuildContext context, String data) async {
    await Clipboard.setData(ClipboardData(text: data));

    CustomToast.showSuccessToast(errorMessage: "Disalin");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13.h, left: 17.h, right: 17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                argument.bankName,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorName.textDarkGrey,
                ),
              ),
              const Spacer(),
              Container(
                height: 30.h,
                width: 50.w,
                color: ColorName.orange,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const CustomDivider(),
          SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nomor Virtual Account",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      argument.virtualAccount,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorName.orange,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _copyToClipboard(
                      context,
                      argument.virtualAccount,
                    ),
                    icon: Text(
                      "Salin",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorName.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const CustomDivider(),
          SizedBox(height: 10.h),
          Text(
            "Total Pembayaran",
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                "Total Harga",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorName.textDarkGrey,
                ),
              ),
              const Spacer(),
              Text(
                argument.totalPrices.toIDR(),
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorName.textDarkGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
