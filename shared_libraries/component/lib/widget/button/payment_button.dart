import 'package:common/utils/extensions/money_extension.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

import 'custom_button.dart';

class PaymentButton extends StatelessWidget {
  final VoidCallback? addToCart;
  final VoidCallback? payment;

  const PaymentButton({
    Key? key,
    required this.addToCart,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: ColorName.textFieldBackgroundGrey,
            width: double.infinity,
            height: 1.h,
          ),
          Container(
            color: ColorName.white,
            padding: EdgeInsets.only(top: 10.h, bottom: 8.h, left: 15.h, right: 15.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: "Beli Langsung",
                    onTap: payment,
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: CustomButton(
                    buttonText: "Keranjang",
                    onTap: addToCart,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentCartButton extends StatelessWidget {
  final int total;
  final String textButton;
  final VoidCallback? paymentTap;

  const PaymentCartButton({
    Key? key,
    required this.total,
    required this.textButton,
    required this.paymentTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: ColorName.textFieldBackgroundGrey,
            width: double.infinity,
            height: 1.h,
          ),
          Container(
            color: ColorName.white,
            padding: EdgeInsets.only(top: 10.h, bottom: 8.h, left: 15.h, right: 15.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Harga",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 8.sp,
                        color: ColorName.textDarkGrey,
                      ),
                    ),
                    Text(
                      total.toIDR(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.sp,
                        color: ColorName.orange,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 123.w,
                  child: CustomButton(
                    buttonColor: (total == 0 || paymentTap == null) ? ColorName.textFieldHintGrey : ColorName.orange,
                    buttonText: textButton,
                    onTap: (total == 0 || paymentTap == null) ? null : paymentTap,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
