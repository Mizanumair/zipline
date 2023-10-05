import 'package:courier_app/src/components/custom_button.dart';
import 'package:courier_app/src/components/custom_divider.dart';
import 'package:courier_app/src/components/custom_text.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:courier_app/src/core/constants/strings.dart';
import 'package:courier_app/src/features/auth/login/login_screen.dart';
import 'package:courier_app/src/features/auth/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/palette.dart';

class SplashTwoScreen extends StatefulWidget {
  const SplashTwoScreen({super.key});

  @override
  State<SplashTwoScreen> createState() => _SplashTwoScreenState();
}

class _SplashTwoScreenState extends State<SplashTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: ListView(
        //    mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: margin_10),
              child: Column(
                children: [
                  CustomDivider(
                    height: height_22,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(image: AssetImage(ImgAssets.skip), width: width_65,)
                      ],
                    ),
                  ),
                  CustomDivider(
                    height: height_40,
                  ),
                  Image(image: AssetImage(ImgAssets.splashTwo)),

                ],
              ),
            ),
            CustomDivider(
              height: height_90,
            ),
            Container(
              height: height_270,
              decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.2),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_30), topRight: Radius.circular(radius_30))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                      text: 'Welcome To Ziplinez',
                      color1: AppColors.white,
                      fontWeight: fontWeight700,
                      fontSize: font_25),
                  CustomText(
                    text: "Lorem Ipsum is simply dummy text of the printing and\ntypesetting industry. Lorem Ipsum has been the\nindustry's standard dummy text ever since the 1500s",
                    color1: AppColors.white,
                    fontWeight: fontWeight700,
                    fontSize: font_12,
                    textAlign: TextAlign.center,
                  ),
                  CustomButton(
                      width: width_340,
                      text: strGetStarted,
                      color: AppColors.white,
                      fontWeight: fontWeight600,
                      font: font_16,
                      onPress: (){
                        Get.off(LoginScreen());
                      }),

                ],
              ),
            ),
          ]),
    );
  }
}
