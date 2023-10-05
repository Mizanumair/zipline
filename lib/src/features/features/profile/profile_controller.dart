import 'dart:convert';

import 'package:courier_app/src/core/constants/user_constants.dart';
import 'package:courier_app/src/features/auth/auth/preferences_service.dart';
import 'package:courier_app/src/features/features/profile/user_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxString imagePath = ''.obs;
  RxBool isLoading = false.obs;
  RxString userGender = ''.obs;
  RxInt updatedProfileCount = 0.obs;
  RxString profilePic = ''.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userPhone = ''.obs;
  RxString userAddress = ''.obs;
  RxString userCompany = ''.obs;


  UserProfileModel userProfile = UserProfileModel();
  SharedPreferences prefs = PreferencesService.instance;

  Future<UserProfileModel?> fetchUserProfile() async {
    isLoading.value = true;
    String userId = prefs.getInt(UserContants.userId).toString();
    print("user id $userId");
    final url = Uri.parse("https://courier.hnktrecruitment.in/fetch-user-profile/$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body.toString());
        userProfile = UserProfileModel.fromJson(jsonData);

        profilePic.value = userProfile.profilePictureUrl.toString();
        userName.value = userProfile.name.toString();
        userEmail.value = userProfile.email.toString();
        userPhone.value = userProfile.mobileNumber.toString();
        userAddress.value = userProfile.address.toString();
        userCompany.value = userProfile.companyName.toString();

        print('fetched profile + ${profilePic.value}');

      } else {
        Fluttertoast.showToast(
          msg: "Failed to fetch user profile",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }

    isLoading.value = false;
    return userProfile;
  }

  Future<bool> updateUserProfile(String companyName, String address, String gender, String profilePicPath,
      String govtIdFrontPath, String govtIdBackPath) async {
    bool isProfileUpdated = false;
    isLoading.value = true;

    final url = Uri.parse('https://courier.hnktrecruitment.in/edit-user-profile');

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = prefs.getInt(UserContants.userId).toString();
      request.fields['company_name'] = companyName;
      request.fields['address'] = address;
      request.fields['gender'] = gender;

      if (govtIdFrontPath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('govt_id_front', govtIdFrontPath));
      }
      if (govtIdBackPath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('govt_id_back', govtIdBackPath));
      }
      if (profilePicPath.isNotEmpty) {
        print('yead' + profilePicPath);
        request.files.add(await http.MultipartFile.fromPath('profile_photo', profilePicPath));
        print('done');
      }

      final response = await request.send();
      var data = await response.stream.bytesToString();
      var jsonData = jsonDecode(data);

      if (response.statusCode == 200) {
        isProfileUpdated = true;
        Fluttertoast.showToast(msg: jsonData['message'], timeInSecForIosWeb: 20);
        updatedProfileCount.value++;
        await fetchUserProfile();
      } else {
        String error = jsonData['error'];
        Fluttertoast.showToast(msg: '$error Try Again', timeInSecForIosWeb: 20, toastLength: Toast.LENGTH_LONG);
        print(error);
      }
    } on Exception catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString(), timeInSecForIosWeb: 20);
    }
    isLoading.value = false;
    return isProfileUpdated;
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path ?? '';
      if (kDebugMode) {
        print('File');
        print(imagePath.value);
      }
    }
  }
}

// final url = Uri.parse("https://courier.hnktrecruitment.in/fetch-user-profile/$userId");
