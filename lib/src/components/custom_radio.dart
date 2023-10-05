import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/features/auth/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import '../core/constants/strings.dart';
import 'custom_text.dart';

class CustomRadioButton extends StatelessWidget {
  CustomRadioButton({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: height_45,
      decoration: BoxDecoration(
          color: AppColors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(radius_10),
          border: Border.all(color: AppColors.white)),
      child: Obx(
        () => Form(
          child: Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStatePropertyAll(AppColors.orange),
                    focusColor: Colors.amber,
                    activeColor: AppColors.orange,
                    value: strMale,
                    groupValue: authController.userGender.value,
                    onChanged: (value) {
                      authController.setUserGender(value.toString());
                    },
                  ),
                  CustomText(text: strMale, color1: AppColors.white, fontWeight: fontWeight400, fontSize: font_13),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    fillColor: MaterialStatePropertyAll(AppColors.orange),
                    activeColor: AppColors.orange,
                    value: strFemale,
                    groupValue: authController.userGender.value,
                    onChanged: (value) {
                      authController.setUserGender(value.toString());
                    },
                  ),
                  CustomText(text: strFemale, color1: AppColors.white, fontWeight: fontWeight400, fontSize: font_13),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
