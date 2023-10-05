import 'package:courier_app/src/core/constants/custom_tiles.dart';
import 'package:courier_app/src/features/auth/forgot_password/forgot_password_controller.dart';
import 'package:courier_app/src/features/auth/forgot_password2/forgot_password_2_controller.dart';
import 'package:courier_app/src/features/auth/otp_mob/otp_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import '../auth/auth.dart';

class ForgotPassword2Screen extends GetView<AuthController> {
  ForgotPassword2Screen({super.key});

  final ForgotPassword2Controller _forgotPassword2Controller = Get.put(ForgotPassword2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: margin_15),
          children: [
            CustomDivider(
              height: height_15,
              isDivider: false,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: CustomText(text: strForget, color1: AppColors.white, fontWeight: fontWeight700, fontSize: font_20),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: CustomText(
                  text: strForgotPass, color1: AppColors.textWhite, fontWeight: fontWeight400, fontSize: font_11),
            ),
            CustomDivider(
              height: height_30,
              isDivider: false,
            ),
            Image.asset(ImgAssets.forgotArt, height: height_250),
            CustomDivider(
              height: height_40,
              isDivider: false,
            ),
            CustomListTile(
              colorBackCircle: AppColors.orange,
              border: AppColors.orange,
              icon: ImgAssets.msgIcon,
              title: strSendCodeSmS,
              subtitle: '+${Get.parameters['phone'].toString().trim()}',
              onTap: () async {
                String phone = Get.parameters['phone'].toString().trim();
                String email = Get.parameters['email'].toString().trim();
                await _forgotPassword2Controller.setUserPhoneAndEmail(phone, email);
                await _forgotPassword2Controller.sendPhoneOTP('+$phone');
              },
              // onTap: ,
            ),
            CustomDivider(
              height: height_16,
              isDivider: false,
            ),
            CustomListTile(
              colorBackCircle: AppColors.orange.withOpacity(.2),
              border: AppColors.white,
              icon: ImgAssets.emailIcon,
              title: strSendCodeEmail,
              subtitle: Get.parameters['email'].toString().trim(),
              onTap: () async {
                String phone = Get.parameters['phone'].toString().trim();
                String email = Get.parameters['email'].toString().trim();
                await _forgotPassword2Controller.setEmailOTPConfig(email);
                // await _forgotPassword2Controller.sendPhoneOTP('+$phone');
                // Get.toNamed('${AppRoutes.forgotOtpEmail}?email=$userEmail&route=forgot');
              },
            ),
            CustomDivider(
              height: height_60,
              isDivider: false,
            ),
            Obx(() => _forgotPassword2Controller.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: strGetOtp,
                    color: AppColors.white,
                    fontWeight: fontWeight800,
                    font: font_16,
                    onPress: () async {
                      // String phone = Get.parameters['phone'].toString().trim();
                      // String email = Get.parameters['email'].toString().trim();
                      // await _forgotPassword2Controller.setUserPhoneAndEmail(phone, email);
                      // await _forgotPassword2Controller.sendPhoneOTP('+$phone');
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
