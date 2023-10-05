import 'package:courier_app/src/components/custom_radio.dart';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/features/auth/register/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import '../auth/auth.dart';

class RegisterScreen extends GetView<AuthController> {
  RegisterScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final RegisterController registerController = Get.put(RegisterController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idFrontController = TextEditingController();
  TextEditingController idBackController = TextEditingController();
  TextEditingController profilePicController = TextEditingController();

  String countryCode = '91';
  String number = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: margin_15),
            children: [
              CustomDivider(
                height: height_15,
                isDivider: false,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                    text: strRegisterNewAc,
                    color1: AppColors.white,
                    fontWeight: fontWeight700,
                    fontSize: font_20),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                    text: strInfoBelow,
                    color1: AppColors.textWhite,
                    fontWeight: fontWeight400,
                    fontSize: font_13),
              ),
              CustomDivider(
                height: height_30,
                isDivider: false,
              ),
              CustomTextField(
                labelText: strEnterName,
                prefixIcon: ImgAssets.userIcon,
                obscure: false,
                height: height_15,
                textInputType: TextInputType.text,
                controller: nameController,
                validator:
                    ValidationBuilder().required('Name is Required').build(),
              ), //email text-field
              CustomTextField(
                labelText: strEnterEmail,
                prefixIcon: ImgAssets.emailIcon,
                obscure: false,
                height: height_15,
                textInputType: TextInputType.text,
                controller: emailAddressController,
                validator: ValidationBuilder()
                    .email()
                    .required('Email is Required')
                    .build(),
              ), //
              CustomTextField(
                  labelText: strEnterCompany,
                  prefixIcon: ImgAssets.companyIcon,
                  obscure: false,
                  height: height_15,
                  textInputType: TextInputType.text,
                  controller: companyNameController,
                  validator: ValidationBuilder()
                      .required('Company Name is Required')
                      .build()), //
              IntlPhoneField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white.withOpacity(.1),
                  labelText: "Enter Phone Number",
                  labelStyle: TextStyle(
                      color: AppColors.white,
                      fontSize: font_14,
                      fontFamily: 'Mukta',
                      fontWeight: fontWeight400),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(color: AppColors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(color: AppColors.white)),
                ),
                dropdownIcon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.white,
                ),
                dropdownTextStyle: TextStyle(color: AppColors.white),
                style: TextStyle(color: AppColors.orange),
                initialCountryCode: 'IN',
                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'Please enter a phone number.';
                  }
                  return null;
                },
                onCountryChanged: (phone) {
                  countryCode = phone.dialCode;
                },
                onChanged: (phone) {
                  number = phone.number;
                  print(countryCode + number);
                },
              ), //
              Obx(
                () => CustomTextField(
                  labelText: strEnterPass,
                  prefixIcon: ImgAssets.passIcon,
                  height: height_15,
                  textInputType: TextInputType.text,
                  controller: passWordController,
                  suffixIcon: IconButton(
                    icon: registerController.isPasswordVisible.value
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    color: AppColors.greyColor,
                    onPressed: () {
                      registerController.isPasswordVisible.value =
                          !registerController.isPasswordVisible.value;
                    },
                  ),
                  obscure: registerController.isPasswordVisible.value,
                  validator: ValidationBuilder()
                      .required('Password is required')
                      .build(),
                ), //
              ),
              Obx(
                () => CustomTextField(
                  labelText: strConfirmPass,
                  prefixIcon: ImgAssets.passIcon,
                  suffixIcon: IconButton(
                    icon: registerController.isConfirmPasswordVisible.value
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    color: AppColors.greyColor,
                    onPressed: () {
                      registerController.isConfirmPasswordVisible.value =
                          !registerController.isConfirmPasswordVisible.value;
                    },
                  ),
                  obscure: registerController.isConfirmPasswordVisible.value,
                  height: height_15,
                  textInputType: TextInputType.text,
                  controller: confirmPassController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field is required';
                    }
                    if (value != passWordController.text) {
                      return 'Passwords do not match';
                    } else {
                      return null;
                    }
                  },
                ), //
              ),

              CustomTextField(
                labelText: strEnterAddress,
                prefixIcon: ImgAssets.locationIcon,
                obscure: false,
                height: height_15,
                textInputType: TextInputType.text,
                controller: addressController,
                validator:
                    ValidationBuilder().required('Address is required').build(),
              ), //

              CustomRadioButton(),

              CustomDivider(
                height: height_15,
              ),

              CustomTextField(
                labelText: strIdFront,
                prefixIcon: ImgAssets.docIcon,
                obscure: false,
                height: height_15,
                textInputType: TextInputType.text,
                controller: idFrontController,
                readOnly: true,
                validator:
                    ValidationBuilder().required('Field is required').build(),
                onTap: () async {
                  await registerController.getImage();
                  idFrontController.text = registerController.imagePath.value;
                },
                suffixIcon: Obx(() {
                  final imagePath = registerController.imagePath.value;
                  return Visibility(
                    visible: idFrontController.text.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        idFrontController.text = '';
                      },
                    ),
                  );
                }),
              ), //
              CustomTextField(
                labelText: strIdBack,
                prefixIcon: ImgAssets.docIcon,
                obscure: false,
                height: height_15,
                textInputType: TextInputType.text,
                controller: idBackController,
                validator: ValidationBuilder().required().build(),
                onTap: () async {
                  await registerController.getImage();
                  idBackController.text = registerController.imagePath.value;
                },
                readOnly: true,
                suffixIcon: Obx(() {
                  final imagePath = registerController.imagePath.value;
                  return Visibility(
                    visible: idBackController.text.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        idBackController.text = '';
                      },
                    ),
                  );
                }),
              ), //

              CustomTextField(
                labelText: strUploadPhoto,
                prefixIcon: ImgAssets.uploadIcon,
                obscure: false,
                height: height_15,
                textInputType: TextInputType.text,
                controller: profilePicController,
                readOnly: true,
                validator:
                    ValidationBuilder().required('Field is required').build(),
                onTap: () async {
                  await registerController.getImage();
                  profilePicController.text =
                      registerController.imagePath.value;
                },
                suffixIcon: Obx(() {
                  final imagePath = registerController.imagePath.value;
                  return Visibility(
                    visible: profilePicController.text.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        profilePicController.text = '';
                      },
                    ),
                  );
                }),
              ), //
              CustomDivider(
                height: height_25,
                isDivider: false,
              ),
              Obx(
                () => authController.isLoading.isTrue
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: strGetOtp,
                        color: AppColors.white,
                        fontWeight: fontWeight800,
                        font: font_16,
                        onPress: () async {
                          if (formKey.currentState!.validate()) {
                            await authController.setUserInformation(
                                name: nameController.text,
                                email: emailAddressController.text,
                                company: companyNameController.text,
                                phone: '+$countryCode$number',
                                passWord: passWordController.text,
                                address: addressController.text,
                                idFront: idFrontController.text,
                                idBack: idBackController.text,
                                profilePhoto: profilePicController.text);
                            if (authController.isEmailVerified.isTrue &&
                                authController.isPhoneVerified.isTrue) {
                              print('bhaaagooooooo!');
                              print(authController.isEmailVerified.isTrue);
                              print(authController.isPhoneVerified.isTrue);
                              await authController.registerUser();
                            } else {
                              // await authController.setEmailOTPConfig(
                              //     emailAddressController
                              //         .text); // comment this line when phone otp is available.

                              await authController.sendPhoneOTP(
                                  '+$countryCode$number'); //uncomment this line when phone otp is available
                            }
                          }
                        },
                      ),
              ),

              CustomDivider(
                height: height_50,
                isDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
