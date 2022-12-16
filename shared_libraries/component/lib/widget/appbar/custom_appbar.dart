import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/assets.gen.dart';
import 'package:resources/colors.gen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback onPressed;
  final Widget? title;
  final Widget? icon;

  const CustomAppBar({Key? key, this.title, this.icon, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: ColorName.orange),
      backgroundColor: ColorName.white,
      elevation: 0.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 35.h,
              child: (title == null)
                  ? TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: ColorName.iconGrey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.5),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13.0,
                          vertical: 5.0,
                        ),
                        hintText: "Sepatu Olahraga",
                        hintStyle: TextStyle(
                          color: ColorName.textFieldHintGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        hoverColor: ColorName.orange,
                        focusColor: ColorName.orange,
                        filled: true,
                        fillColor: ColorName.textFieldBackgroundGrey,
                      ),
                    )
                  : title,
            ),
          ),
          SizedBox(
            width: 19.w,
          ),
          InkWell(
            onTap: onPressed,
            child: (icon == null) ? Assets.images.icon.cart.svg(width: 24.w, height: 24.h) : icon,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(55.h);
}
