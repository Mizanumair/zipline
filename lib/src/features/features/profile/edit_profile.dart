import 'dart:io';

import 'package:courier_app/src/features/features/profile/profile_controller.dart';
import 'package:courier_app/src/features/features/profile/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  String profilePicUrl = '';

  String updatedProfilePic = '';

  TextEditingController govIdBackController = TextEditingController();

  TextEditingController govIdFrontController = TextEditingController();

  int profileUpdateCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    profileController.fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppbar(
        appBar: AppBar(),
        title: strEditProfile,
        containerColor: AppColors.transparent,
        text: '',
        color: AppColors.transparent,
      ),
      body: SafeArea(
        child: Obx(() {
          UserProfileModel userProfile = profileController.userProfile;
          if (profileController.isLoading.isTrue) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.orange,
            ));
          } else {
            if (userProfile.name == null) {
              return const Center(
                child: Text('Error Loading Data, Try Again Later'),
              );
            } else {
              profilePicUrl = profileController.profilePic.value;
              nameController.text = profileController.userName.value;
              emailController.text = profileController.userEmail.value;
              phoneController.text = profileController.userPhone.value;
              companyController.text = profileController.userCompany.value;
              addressController.text = profileController.userAddress.value;
              genderController.text = userProfile.gender.toString();
              profileController.userGender.value = userProfile.gender.toString();

              print(profilePicUrl);
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: margin_15),
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          profileController.getImage();
                          updatedProfilePic = profileController.imagePath.value;
                        },
                        child: Obx(
                          () => profileController.imagePath.value.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(profileController.imagePath.value)),
                                  radius: radius_40,
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                                )
                              : profilePicUrl.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(profilePicUrl),
                                      radius: radius_40,
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: const AssetImage(ImgAssets.badge),
                                      radius: radius_40,
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                                    ),
                        ),
                      ),
                    ],
                  ),

                  CustomDivider(
                    height: height_15,
                    isDivider: false,
                  ),
                  CustomTextField(
                    labelText: strEnterName,
                    prefixIcon: ImgAssets.userIcon,
                    obscure: false,
                    height: height_15,
                    textInputType: TextInputType.text,
                    controller: nameController,
                    readOnly: true,
                    validator: ValidationBuilder().required('Name is Required').build(),
                  ),
                  //  CustomProfContainer(
                  //   assetName: ImgAssets.userIcon,
                  //   text: nameController.text,
                  // ),
                  CustomTextField(
                    labelText: strEnterEmail,
                    prefixIcon: ImgAssets.emailIcon,
                    obscure: false,
                    height: height_15,
                    textInputType: TextInputType.text,
                    controller: emailController,
                    readOnly: true,
                    validator: ValidationBuilder().email().required('Email is Required').build(),
                  ),
                  // CustomProfContainer(
                  //   assetName: ImgAssets.emailIcon,
                  //   text: emailController.text ,
                  // ),
                  CustomTextField(
                    labelText: strMobNo,
                    prefixIcon: ImgAssets.phoneIcon,
                    obscure: false,
                    height: height_15,
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                    readOnly: true,
                    validator: ValidationBuilder()
                        .phone('Enter a valid phone number')
                        .required('Phone Number is required')
                        .build(),
                  ),
                  // const CustomProfContainer(
                  //   assetName: ImgAssets.phoneIcon,
                  //   text: phoneController,
                  // ),
                  CustomTextField(
                    labelText: strEnterCompany,
                    prefixIcon: ImgAssets.companyIcon,
                    obscure: false,
                    controller: companyController,
                    height: height_15,
                    textInputType: TextInputType.text,
                    color: AppColors.transparent,

                  ),
                  CustomTextField(
                    labelText: 'Lucknow, Uttar Pradesh',
                    prefixIcon: ImgAssets.locationIcon,
                    obscure: false,
                    height: height_15,
                    controller: addressController,
                    textInputType: TextInputType.text,
                    color: AppColors.transparent,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStatePropertyAll(AppColors.orange),
                              activeColor: AppColors.orange,
                              value: 'Male',
                              groupValue: profileController.userGender.value,
                              onChanged: (value) {
                                genderController.text = value.toString();
                                profileController.userGender.value = value.toString();
                              },
                            ),
                            CustomText(
                                text: 'Male',
                                color1: AppColors.textWhite,
                                fontWeight: fontWeight400,
                                fontSize: font_13),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStatePropertyAll(AppColors.orange),
                              activeColor: AppColors.orange,
                              value: 'Female',
                              groupValue: profileController.userGender.value,
                              onChanged: (value) {
                                genderController.text = value.toString();
                                profileController.userGender.value = value.toString();
                              },
                            ),
                            CustomText(
                                text: 'Female',
                                color1: AppColors.textWhite,
                                fontWeight: fontWeight400,
                                fontSize: font_13),
                          ],
                        )
                      ],
                    ),
                  ),
                  CustomDivider(
                    height: height_15,
                    isDivider: false,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin_120),
                    child: Obx(
                      () => profileController.isLoading.isTrue
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.orange,
                            ))
                          : CustomButton(
                              text: strSave,
                              color: AppColors.white,
                              fontWeight: fontWeight600,
                              font: font_15,
                              onPress: () async {
                                print('file image $updatedProfilePic');
                                print('api image ${profileController.imagePath.value}');
                                bool isUpdated = await profileController.updateUserProfile(
                                    companyController.text,
                                    addressController.text,
                                    genderController.text,
                                    profileController.imagePath.value,
                                    govIdFrontController.text,
                                    govIdBackController.text);
                                // if (profileController.imagePath.value.isNotEmpty) {
                                //   profileController.imagePath.value = '';
                                // }
                              },
                            ),
                    ),
                  ),
                  CustomDivider(
                    height: height_55,
                    isDivider: false,
                  ),
                ],
              );
            }
          }
        }),
      ),
    );
  }
}

/*


FutureBuilder<UserProfileModel?>(
            future: profileController.fetchUserProfile(),
            builder: (BuildContext context, AsyncSnapshot<UserProfileModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.orange,
                ));
              } else if (snapshot.hasData) {
                profilePicUrl = snapshot.data!.profilePictureUrl.toString();
                nameController.text = snapshot.data!.name.toString();
                emailController.text = snapshot.data!.email.toString();
                phoneController.text = snapshot.data!.mobileNumber.toString();
                companyController.text = snapshot.data!.companyName.toString();
                addressController.text = snapshot.data!.address.toString();
                genderController.text = snapshot.data!.gender.toString();
                profileController.userGender.value = snapshot.data!.gender.toString();

                print(profilePicUrl);

                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: margin_15),
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            profileController.getImage();
                            updatedProfilePic = profileController.imagePath.value;
                          },
                          child: Obx(
                            () => profileController.imagePath.value.isNotEmpty
                                ? CircleAvatar(
                                    backgroundImage: FileImage(File(profileController.imagePath.value)),
                                    radius: radius_40,
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                                  )
                                : profilePicUrl.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(profilePicUrl),
                                        radius: radius_40,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: const AssetImage(ImgAssets.badge),
                                        radius: radius_40,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                                      ),
                          ),
                        ),
                      ],
                    ),

                    CustomDivider(
                      height: height_15,
                      isDivider: false,
                    ),
                    CustomTextField(
                      labelText: strEnterName,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.userIcon),
                      ),
                      obscure: false,
                      height: height_15,
                      textInputType: TextInputType.text,
                      controller: nameController,
                      readOnly: true,
                      validator: ValidationBuilder().required('Name is Required').build(),
                    ),
                    //  CustomProfContainer(
                    //   assetName: ImgAssets.userIcon,
                    //   text: nameController.text,
                    // ),
                    CustomTextField(
                      labelText: strEnterEmail,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.emailIcon),
                      ),
                      obscure: false,
                      height: height_15,
                      textInputType: TextInputType.text,
                      controller: emailController,
                      readOnly: true,
                      validator: ValidationBuilder().email().required('Email is Required').build(),
                    ),
                    // CustomProfContainer(
                    //   assetName: ImgAssets.emailIcon,
                    //   text: emailController.text ,
                    // ),
                    CustomTextField(
                      labelText: strMobNo,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.phoneIcon),
                      ),
                      obscure: false,
                      height: height_15,
                      textInputType: TextInputType.phone,
                      controller: phoneController,
                      readOnly: true,
                      validator: ValidationBuilder()
                          .phone('Enter a valid phone number')
                          .required('Phone Number is required')
                          .build(),
                    ),
                    // const CustomProfContainer(
                    //   assetName: ImgAssets.phoneIcon,
                    //   text: phoneController,
                    // ),
                    CustomTextField(
                      labelText: strEnterCompany,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.companyIcon),
                      ),
                      obscure: false,
                      controller: companyController,
                      height: height_15,
                      textInputType: TextInputType.text,
                    ),
                    CustomTextField(
                      labelText: 'Lucknow, Uttar Pradesh',
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.locationIcon),
                      ),
                      obscure: false,
                      height: height_15,
                      controller: addressController,
                      textInputType: TextInputType.text,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                activeColor: AppColors.orange,
                                value: 'Male',
                                groupValue: profileController.userGender.value,
                                onChanged: (value) {
                                  genderController.text = value.toString();
                                  profileController.userGender.value = value.toString();
                                },
                              ),
                              CustomText(
                                  text: 'Male',
                                  color1: AppColors.greyColor,
                                  fontWeight: fontWeight400,
                                  fontSize: font_13),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                activeColor: AppColors.orange,
                                value: 'Female',
                                groupValue: profileController.userGender.value,
                                onChanged: (value) {
                                  genderController.text = value.toString();
                                  profileController.userGender.value = value.toString();
                                },
                              ),
                              CustomText(
                                  text: 'Female',
                                  color1: AppColors.greyColor,
                                  fontWeight: fontWeight400,
                                  fontSize: font_13),
                            ],
                          )
                        ],
                      ),
                    ),
                    CustomDivider(
                      height: height_15,
                      isDivider: false,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin_120),
                      child: Obx(
                        () => profileController.isLoading.isTrue
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.orange,
                              ))
                            : CustomButton(
                                text: strSave,
                                color: AppColors.white,
                                fontWeight: fontWeight600,
                                font: font_15,
                                onPress: () async {
                                  print('file image $updatedProfilePic');
                                  print('api image ${profileController.imagePath.value}');
                                  bool isUpdated = await profileController.updateUserProfile(
                                      companyController.text,
                                      addressController.text,
                                      genderController.text,
                                      profileController.imagePath.value,
                                      govIdFrontController.text,
                                      govIdBackController.text);
                                  // if (profileController.imagePath.value.isNotEmpty) {
                                  //   profileController.imagePath.value = '';
                                  // }
                                },
                              ),
                      ),
                    ),
                    CustomDivider(
                      height: height_55,
                      isDivider: false,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Error Loading Data, Try Again Later'),
                );
              }
            }),
* */

/*
                 CustomTextField(
                      labelText: strIdBack,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.docIcon),
                      ),
                      obscure: false,
                      height: height_15,
                      textInputType: TextInputType.text,
                      controller: govIdBackController,
                      validator: ValidationBuilder().required().build(),
                      onTap: () async {
                        await controller.getImage();
                        govIdBackController.text = profileController.imagePath.value;
                      },
                      readOnly: true,
                      suffixIcon: Obx(() {
                        final imagePath = profileController.imagePath.value;
                        return Visibility(
                          visible: govIdBackController.text.isNotEmpty,
                          child: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              govIdBackController.text = '';
                            },
                          ),
                        );
                      }),
                    ), //

                    CustomTextField(
                      labelText: strIdFront,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.uploadIcon),
                      ),
                      obscure: false,
                      height: height_15,
                      textInputType: TextInputType.text,
                      controller: govIdFrontController,
                      readOnly: true,
                      validator: ValidationBuilder().required('Field is required').build(),
                      onTap: () async {
                        await profileController.getImage();
                        govIdFrontController.text = profileController.imagePath.value;
                      },
                      suffixIcon: Obx(() {
                        final imagePath = profileController.imagePath.value;
                        return Visibility(
                          visible: govIdFrontController.text.isNotEmpty,
                          child: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              govIdFrontController.text = '';
                            },
                          ),
                        );
                      }),
                    ),
                    CustomDivider(
                      height: height_15,
                      isDivider: false,
                    ),
*/
