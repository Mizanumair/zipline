import 'package:flutter/material.dart';

import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import '../core/constants/strings.dart';
import 'custom_about_package.dart';
import 'custom_text.dart';

class CustomSenderDetails extends StatelessWidget {
  const CustomSenderDetails({Key?key,
    required this.name,
    required this.contact,
    required this.email,
    required this.address,
    required this.heading,

  }): super(key: key);

  final String name;
  final String contact;
  final String email;
  final String address;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          heightFactor: height_1,
          alignment: Alignment.topLeft,
          child: CustomText(
          text: heading,
          color1: AppColors.white,
          fontWeight: fontWeight600,
          fontSize: font_15),
        ),

        Container(
          //height: height_200,
          //width: width_60,
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(radius_20),
              border: Border.all(color: AppColors.greyColor.withOpacity(.3))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              line(text: strName, text2: name),
              line(text: strContact, text2: contact),
              line(text: strEmail, text2: email),
              line(text: strAddress, text2: address),
            ],
          ),
        ),
      ],
    );
  }
}

