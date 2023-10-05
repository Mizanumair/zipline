import 'package:courier_app/src/components/custom_text_button.dart';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/core/constants/assets.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/user_constants.dart';
import 'package:courier_app/src/features/auth/auth/preferences_service.dart';
import 'package:courier_app/src/features/auth/login/login_screen.dart';
import 'package:courier_app/src/features/features/profile/edit_profile.dart';
import 'package:courier_app/src/features/features/profile/profile_controller.dart';
import 'package:courier_app/src/features/features/profile/user_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, this.navigatedFromNavBar = false});

  bool navigatedFromNavBar;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences prefs = PreferencesService.instance;

  ProfileController profileController = Get.put(ProfileController());

  String galleryImagePath = '';

  int profileUpdatedCount = 0;

  @override
  void initState() {
    super.initState();
    // profileController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppbar(
        appBar: AppBar(),
        dontShowBackButton: widget.navigatedFromNavBar,
        title: strProfile,
        containerColor: AppColors.transparent,
        text: '',
        color: AppColors.transparent,
      ),
      body: SafeArea(
        child: Obx(() {
          profileUpdatedCount = profileController.updatedProfileCount.value;
          UserProfileModel profile = profileController.userProfile;
          String userName = profile.name.toString();
          String userEmail = profile.email.toString();
          String userProfileUrl = profile.profilePictureUrl.toString();
            if (profileController.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.orange,
                ),
              );
            } else {
              print('profile pic url + ${userProfileUrl}');
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: margin_15),
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      userProfileUrl.isNotEmpty
                          ? CircleAvatar(
                        backgroundImage: NetworkImage(userProfileUrl),
                        radius: radius_40,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Image(image:  AssetImage(ImgAssets.badge), height: height_22)),
                      )
                          : CircleAvatar(
                        backgroundImage: const AssetImage(ImgAssets.badge),
                        radius: radius_40,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    // heightFactor: 1.5,
                    child: CustomText(
                        text: userName, color1: AppColors.white, fontWeight: fontWeight700, fontSize: font_20),
                  ),
                  Align(
                    alignment: Alignment.center,
                    //heightFactor: .1,
                    child: CustomText(
                        text: userEmail, color1: AppColors.textWhite, fontWeight: fontWeight400, fontSize: font_13),
                  ),
                  CustomDivider(
                    height: height_25,
                    color: AppColors.white,
                    isDivider: false,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width_100),
                    child: CustomButton(
                      text: strEditProfile,
                      color: AppColors.white,
                      fontWeight: fontWeight800,
                      font: font_16,
                      onPress: () {
                        Get.to(EditProfileScreen());
                      },
                    ),
                  ),
                  CustomDivider(
                    height: height_25,
                    isDivider: false,
                  ),
                  Divider(
                    color: AppColors.greyColor.withOpacity(.2),
                    thickness: 1,
                    height: height_10,
                    indent: 20,
                    endIndent: 20,
                  ),
                  CustomDivider(
                    height: height_20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          prefs.remove(UserContants.userId);
                          setState(() {
                          });
                          Get.offAll(LoginScreen());
                        },
                        child: SizedBox(
                          width: width_120,
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Image(
                                image: AssetImage(ImgAssets.logOut),
                                width: width_30,
                              ),
                              CustomTextButton(
                                  text: strLogout,
                                  color: AppColors.orange,
                                  fontWeight: fontWeight700,
                                  font: font_16,
                                  onPress: () {

                                  })
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width_150,
                        //color: Colors.amber,
                        height: height_20,
                      )
                    ],
                  )
                ],
              );
            }

        })
      ),
    );
  }
}
// FutureBuilder<UserProfileModel?>(
// future: profileController.fetchUserProfile(),
// builder: (BuildContext context, AsyncSnapshot<UserProfileModel?> snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const Center(
// child: CircularProgressIndicator(
// color: AppColors.orange,
// ),
// );
// } else if (snapshot.hasData) {
// String userName = snapshot.data!.name.toString();
// String userEmail = snapshot.data!.email.toString();
// String userProfileUrl = snapshot.data!.profilePictureUrl.toString();
// print('profile pic url + ${userProfileUrl}');
// return ListView(
// padding: EdgeInsets.symmetric(horizontal: margin_15),
// children: [
// Stack(
// alignment: Alignment.center,
// children: [
// userProfileUrl.isNotEmpty
// ? CircleAvatar(
// backgroundImage: NetworkImage(userProfileUrl),
// radius: radius_40,
// child: Align(
// alignment: Alignment.bottomRight,
// child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
// )
//     : CircleAvatar(
// backgroundImage: const AssetImage(ImgAssets.badge),
// radius: radius_40,
// child: Align(
// alignment: Alignment.bottomRight,
// child: Image(image: const AssetImage(ImgAssets.camera), height: height_22)),
// ),
// ],
// ),
// Align(
// alignment: Alignment.center,
// // heightFactor: 1.5,
// child: CustomText(
// text: userName, color1: AppColors.black, fontWeight: fontWeight700, fontSize: font_20),
// ),
// Align(
// alignment: Alignment.center,
// //heightFactor: .1,
// child: CustomText(
// text: userEmail, color1: AppColors.greyColor, fontWeight: fontWeight400, fontSize: font_13),
// ),
// CustomDivider(
// height: height_25,
// isDivider: false,
// ),
// Padding(
// padding: EdgeInsets.symmetric(horizontal: width_100),
// child: CustomButton(
// text: strEditProfile,
// color: AppColors.white,
// fontWeight: fontWeight800,
// font: font_16,
// onPress: () {
// Get.to(EditProfileScreen());
// },
// ),
// ),
// CustomDivider(
// height: height_25,
// isDivider: false,
// ),
// Divider(
// color: AppColors.greyColor.withOpacity(.2),
// thickness: 1,
// height: height_10,
// indent: 20,
// endIndent: 20,
// ),
// CustomDivider(
// height: height_20,
// ),
// Row(
// textBaseline: TextBaseline.alphabetic,
// children: [
// Image(
// image: AssetImage(ImgAssets.logOut),
// width: width_30,
// ),
// CustomTextButton(
// text: strLogout,
// color: AppColors.orange,
// fontWeight: fontWeight700,
// font: font_16,
// onPress: () {
// prefs.remove(UserContants.userId);
// Get.offAll(LoginScreen());
// })
// ],
// )
// ],
// );
// } else {
// return const Center(
// child: Text('An Error Occurred'),
// );
// }
// })