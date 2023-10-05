import 'package:courier_app/src/components/custom_textTwo.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:flutter/material.dart';

import '../core/constants/palette.dart';
import 'custom_divider.dart';

class CustomProfContainer extends StatelessWidget {
  const CustomProfContainer({Key?key,
    required this.assetName,
    required this.text,

  }): super(key: key);

  final String assetName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //height: height_50,
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(.15),
            borderRadius: BorderRadius.circular(radius_10),
            border: Border.all(color: AppColors.greyColor.withOpacity(.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDivider(
                width: width_10,
                isDivider: false,
              ),
              Image(image: AssetImage(assetName)),
              CustomDivider(
                width: width_10,
                isDivider: false,
              ),
              SizedBox(
                width: width_250,
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: height_15),
                  child: CustomText(
                      text: text,
                      fontWeight: fontWeight400,
                      fontSize: font_16,
                      textColor: AppColors.greyColor),
                ),
              )
            ],
          ),
        ),
        CustomDivider(
          height: height_15,
          isDivider: false,
        ),
      ],
    );
  }
}
