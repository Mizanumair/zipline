import 'package:courier_app/src/components/custom_divider.dart';
import 'package:courier_app/src/core/constants/assets.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:courier_app/src/core/constants/strings.dart';
import 'package:courier_app/src/features/features/item_details/complete_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/constants/dimensions.dart';
import '../core/constants/palette.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class ShippingChip extends StatelessWidget {
  const ShippingChip({
    Key? key,
    required this.orderUidNo,
    required this.senderName,
    required this.recieverName,
    required this.productName,
    required this.time,
    required this.buttonName,
    required this.buttonColor,
    required this.productImageUrl,
    this.bgColor,
    this.boxShadow,
  }) : super(key: key);

  final String orderUidNo;
  final String senderName;
  final String recieverName;
  final String productName;
  final String time;
  final String buttonName;
  final Color buttonColor;
  final String productImageUrl;
  final Color? bgColor;
  final double? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height_220,
          // width: width_100,
          decoration: BoxDecoration(
              color: bgColor ?? AppColors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(radius_8),
              boxShadow: [
                BoxShadow(
                    color: AppColors.greyColor.withOpacity(.2), blurRadius: 12, offset: Offset(0, 0), spreadRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: CustomText(
                  text: strOrderUid,
                  color1: AppColors.textWhite,
                  fontWeight: fontWeight600,
                  fontSize: font_12,
                ),
                subtitle: CustomText(
                  text: orderUidNo,
                  color1: AppColors.white,
                  fontWeight: fontWeight600,
                  fontSize: font_18,
                ),
                trailing: SizedBox(
                  height: 40,
                  child: CustomButton(
                      buttonColor: buttonColor,
                      text: buttonName,
                      color: AppColors.white,
                      fontWeight: fontWeight600,
                      font: font_15,
                      onPress: () {}),
                ),
              ),
              Divider(
                height: 20,
                color: AppColors.white,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: margin_15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: strSenderName,
                          color1: AppColors.textWhite,
                          fontWeight: fontWeight600,
                          fontSize: font_12,
                        ),
                        CustomText(
                          text: senderName,
                          color1: AppColors.white,
                          fontWeight: fontWeight600,
                          fontSize: font_18,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          text: strRecieverName,
                          color1: AppColors.textWhite,
                          fontWeight: fontWeight600,
                          fontSize: font_12,
                        ),
                        CustomText(
                          text: recieverName,
                          color1: AppColors.white,
                          fontWeight: fontWeight600,
                          fontSize: font_18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomDivider(
                height: height_10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height_80,
                    width: width_100,
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(radius_8)),
                    child: Image(image: NetworkImage(productImageUrl)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: productName,
                        color1: AppColors.white,
                        fontWeight: fontWeight600,
                        fontSize: font_18,
                      ),
                      CustomText(
                        text: time,
                        color1: AppColors.textWhite,
                        fontWeight: fontWeight600,
                        fontSize: font_12,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined, size: height_20, color: AppColors.white,),
                ],
              ),
            ],
          ),
        ),
        CustomDivider(
          height: height_25,
        )
      ],
    );
  }
}
