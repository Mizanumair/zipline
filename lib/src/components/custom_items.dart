import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:flutter/material.dart';

import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import '../core/constants/strings.dart';
import 'custom_text.dart';

class CustomItems extends StatelessWidget {
  const CustomItems({Key?key,
    required this.image,
    required this.text,
    this.onTap,
  }): super(key:key);

  final AssetImage image;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: margin_15),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(radius_8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image(image: image,),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 80,
              child: CustomText(
                  text: text,
                  color1: AppColors.textWhite,
                  fontWeight: fontWeight600,
                  fontSize: font_16,
              textAlign: TextAlign.center
              ),
            ),

          ],
        ),
      ),
    );
  }
}
