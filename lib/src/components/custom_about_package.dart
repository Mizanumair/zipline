import 'package:courier_app/src/components/custom_divider.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:courier_app/src/core/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/font_weight.dart';
import 'custom_text.dart';

class CustomAboutPack extends StatelessWidget {
  const CustomAboutPack({
    Key? key,
    required this.senderName,
    required this.recieverName,
    required this.charges,
    required this.deliveryRequires,
    required this.category,
    required this.weight,
    required this.size,
  }) : super(key: key);

  final String senderName;
  final String recieverName;
  final String charges;
  final String deliveryRequires;
  final String category;
  final String weight;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height_330,
      //width: width_60,
      decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(radius_20),
          border: Border.all(color: AppColors.greyColor.withOpacity(.3))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          line(text: strSenderName, text2: senderName),
          line(text: strRecieverName, text2: recieverName),
          line(text: strCharges, text2: charges),
          line(text: strDeliveryRequires, text2: deliveryRequires),
          line(text: strItemType, text2: category),
          line(text: strWeight, text2: weight),
          line(text: strSize, text2: size),
        ],
      ),
    );
  }
}

Widget line({required String text, required String text2}) {
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
            CustomText(text: text, color1: AppColors.textWhite, fontWeight: fontWeight500, fontSize: font_12),
            Container(
              alignment: Alignment.centerRight,
              width: width_150,
              child: CustomText(
                  textAlign: TextAlign.end,
                  text: text2, color1: AppColors.white, fontWeight: fontWeight600, fontSize: font_15),
            ),
          ],
        ),
        Divider(
          height: height_10,
          color: AppColors.textWhite,
        ),
      ],
    ),
  );
}
