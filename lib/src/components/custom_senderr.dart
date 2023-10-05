import 'package:courier_app/src/core/constants/assets.dart';
import 'package:flutter/material.dart';

import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import '../core/constants/strings.dart';
import 'custom_about_package.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class CustomSender extends StatelessWidget {
  const CustomSender({
    Key? key,
    required this.name,
    required this.size,
    required this.imgText,
    required this.weight,
    required this.types,
    required this.category,
    required this.delivery,
    required this.charges,
    required this.heading,
  }) : super(key: key);

  final String name;
  final String size;
  final String imgText;
  final String weight;
  final String types;
  final String category;
  final String delivery;
  final String charges;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          heightFactor: height_1,
          alignment: Alignment.topLeft,
          child: CustomText(text: heading, color1: AppColors.white, fontWeight: fontWeight600, fontSize: font_15),
        ),
        Container(
          // height: height_300,
          //width: width_60,
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(radius_20),
              border: Border.all(color: AppColors.white.withOpacity(.3))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              line(text: strItemName, text2: name),
              line(text: strItemsSize, text2: size),
              lineImage(text: strItemImage, text2: imgText),
              line(text: strItemsWeight, text2: weight),
              line(text: strItemType, text2: types),
              line(text: strItemCategory, text2: category),
              line(text: strDeliveryRequired, text2: delivery),
              line(text: strCharges, text2: charges),
            ],
          ),
        ),
      ],
    );
  }

  Widget lineImage({required String text, required String text2}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin_20),
      child: Column(
        children: [
          CustomDivider(
            height: height_10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: text, color1: AppColors.white, fontWeight: fontWeight500, fontSize: font_12),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_5),
                  image: DecorationImage(
                    image: NetworkImage(text2),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: height_10,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
