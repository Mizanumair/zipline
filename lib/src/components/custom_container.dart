
import 'package:courier_app/src/features/features/add_order/add_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/constants/assets.dart';
import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import '../core/constants/strings.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key,
    required this.title,
    required this.assetImage,

  }): super(key: key);


  final String title;
  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Container(
          height: height_45,
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(radius_10),
              border: Border.all(color: AppColors.white)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomDivider(
                    width: width_12,
                    isDivider: false,
                  ),
                  Image(image: assetImage),
                  CustomDivider(
                    width: width_10,
                    isDivider: false,
                  ),
                  CustomText(
                      text: title,
                      color1: AppColors.textWhite,
                      fontWeight: fontWeight400,
                      fontSize: font_13),
                ],
              ),

            ],
          ),
        ),

        // if(isOpen)
        //   ListView(
        //     primary: true,
        //     shrinkWrap: true,
        //     children: controller.dropdownItems.map((e) => Container(
        //       alignment: Alignment.center,
        //       height: height_40,
        //       width: width_40,
        //       decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.circular(radius_10)
        //       ),
        //
        //       child: InkWell(
        //           onTap: (){
        //             controller.selectedValue = e;
        //             isOpen=false;
        //             setState(() {
        //
        //             });
        //           },
        //           child: CustomText(
        //               text: e,
        //             color1: AppColors.greyColor,
        //             fontWeight: fontWeight600,
        //             fontSize: font_12,
        //           )),
        //     )).toList(),
        //   ),
        CustomDivider(
          height: height_15,
          isDivider: false,
        ),
      ],
    );
  }
}

