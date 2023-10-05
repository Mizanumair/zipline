import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/features/auth/auth/auth.dart';
import 'package:courier_app/src/features/auth/forgot_password2/forgot_password_2_controller.dart';
import 'package:courier_app/src/features/auth/new_password/new_password_screen.dart';
import 'package:courier_app/src/features/auth/otp_email/otp_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';

class OTPEmailScreen extends GetView<AuthController> {
  OTPEmailScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final ForgotPassword2Controller forgotPassword2Controller = Get.put(ForgotPassword2Controller());
  final TextEditingController otpController = TextEditingController();

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
          child:
              CustomText(text: strEnterEmailOtp, color1: AppColors.white, fontWeight: fontWeight700, fontSize: font_20),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
              text: '$strOtpEmail ${Get.parameters['email']}',
              color1: AppColors.textWhite,
              fontWeight: fontWeight400,
              fontSize: font_13),
        ),
        CustomDivider(
          height: height_30,
          isDivider: false,
        ),
        Image.asset(ImgAssets.otpArt, height: height_250),
        CustomDivider(
          height: height_30,
          isDivider: false,
        ),
        Pinput(
          submittedPinTheme: PinTheme(
            textStyle: TextStyle(color: AppColors.white, fontSize: font_25),
            height: height_50,
            width: width_60,
            decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.3),
                borderRadius: BorderRadius.circular(radius_10),
                border: Border.all(color: AppColors.textWhite)),),
          length: 6,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          defaultPinTheme: PinTheme(
              height: height_50,
              width: width_60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_10),
                  border: Border.all(color: AppColors.greyColor.withOpacity(.4))),
              textStyle: TextStyle(fontSize: font_20, fontWeight: fontWeight600)),
          focusedPinTheme: PinTheme(
            height: height_50,
            width: width_60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_10), border: Border.all(color: AppColors.white)),
            textStyle: TextStyle(fontSize: font_20, fontWeight: fontWeight600),
          ),
          controller: otpController,
        ),
        CustomDivider(
          height: height_10,
          isDivider: false,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: authController.isTimerRunning.isTrue
                    ? null
                    : () {
                        authController.setEmailOTPConfig(Get.parameters['email']!);
                      },
                child: CustomText(
                  text: strResendCode,
                  color1: authController.isTimerRunning.isTrue ? AppColors.greyColor : AppColors.blue,
                  fontWeight: fontWeight400,
                  fontSize: font_13,
                ),
              ),
              if (authController.isTimerRunning.isTrue)
                CustomText(
                  text: ' ${authController.otpResendTimer.value.toString()}s',
                  color1: AppColors.orange,
                  fontWeight: fontWeight600,
                  fontSize: font_13,
                ),
            ],
          ),
        ),
        CustomDivider(
          height: height_100,
          isDivider: false,
        ),
        Obx(
          () => authController.isLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  text: strVefiry,
                  color: AppColors.white,
                  fontWeight: fontWeight800,
                  font: font_16,
                  onPress: () async {
                    if (Get.parameters['route'].toString() == 'forgot') {
                      await forgotPassword2Controller.verifyEmailOTP2(otpController.text);
                    } else {
                      await authController.verifyEmailOTP2(otpController.text);
                    }
                  },
                ),
        ),
      ],
    )));
  }
}
