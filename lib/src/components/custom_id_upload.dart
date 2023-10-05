
import 'package:courier_app/src/components/custom_text.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:flutter/material.dart';

import 'custom_divider.dart';

class CustomIdUpload extends StatelessWidget {
  const CustomIdUpload({Key?key,
    required this.assetName,
    required this.text,
    this.onTap,

  }): super(key: key);

  final AssetImage assetName;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(radius_10),
            border: Border.all(color: AppColors.greyColor.withOpacity(.3))
        ),
        child: Row(
          children: [
            CustomDivider(
              width: width_12,
              isDivider: false,
            ),
            Image(image: assetName),
            CustomDivider(
              width: width_15,
              isDivider: false,
            ),
            CustomText(text: text, color1: AppColors.greyColor, fontWeight: fontWeight400, fontSize: font_14)
          ],
        ),
      ),
    );
  }
}

