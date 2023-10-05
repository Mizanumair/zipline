import 'package:courier_app/src/components/custom_button.dart';
import 'package:courier_app/src/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/assets.dart';
import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import 'custom_container.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {Key? key,
      required this.appBar,
      this.text,
      this.containerColor,
      this.onPress,
      required this.title,
      this.color,
      this.dontShowBackButton = false})
      : super(key: key);

  final AppBar appBar;
  final String? text;
  final Color? containerColor;
  final String title;
  final Function()? onPress;
  final Color? color;
  final bool dontShowBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      leading: dontShowBackButton
          ? const SizedBox(width: 5,)
          : IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              ),
            ),
      titleSpacing: width_1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color1: AppColors.white, fontWeight: fontWeight700, fontSize: font_20),
          Padding(
            padding: EdgeInsets.only(right: margin_10),
            child: Container(
              // height: 45,

              child: ElevatedButton(
                onPressed: onPress,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(containerColor),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius_10)),
                  ),
                  elevation: MaterialStatePropertyAll(0),
                ),
                child: CustomText(
                  text: text!,
                  color1: color!,
                  fontWeight: fontWeight500,
                  fontSize: font_15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  Size get preferredSizeWidth => Size.fromWidth(appBar.preferredSize.width);
}
