import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/core/constants/user_constants.dart';
import 'package:courier_app/src/features/auth/auth/login_user_model.dart';
import 'package:courier_app/src/features/auth/auth/preferences_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailOTP emailAuth2 = EmailOTP();

  RxString verificationId = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isPhoneCodeSent = false.obs;
  RxBool isPhoneVerified = false.obs;
  RxBool isEmailCodeSent = false.obs;
  RxBool isEmailVerified = false.obs;
  RxBool isTimerRunning = false.obs;
  RxInt otpResendTimer = 0.obs;
  int? resendToken;

  RxBool isUserLoggedIn = false.obs;

  final SharedPreferences prefs = PreferencesService.instance;

  String userName = '';
  String userEmail = '';
  String userPhone = '';
  String companyName = '';
  String password = '';
  String userAddress = '';
  String userIdFront = '';
  String userIdBack = '';
  String userProfilePhoto = '';
  RxString userGender = ''.obs;
  String phoneOtpId = '';

  RxString registerStatus = ''.obs;

  void setUserGender(String gender) {
    userGender.value = gender;
  }

  Future<void> setUserInformation({
    required String name,
    required String email,
    required String company,
    required String phone,
    required String passWord,
    required String address,
    required String idFront,
    required String idBack,
    required String profilePhoto,
  }) async {
    isLoading.value = true;
    userName = name;
    userEmail = email;
    password = passWord;
    userPhone = phone;
    companyName = company;
    userAddress = address;
    userIdFront = idFront;
    userIdBack = idBack;
    userProfilePhoto = profilePhoto;

    await prefs.setString(UserContants.userName, name);
    await prefs.setString(UserContants.userEmail, email);
    await prefs.setString(UserContants.passWord, passWord);
    await prefs.setString(UserContants.userPhone, phone);
    await prefs.setString(UserContants.companyName, company);
    await prefs.setString(UserContants.userAddress, address);
    await prefs.setString(UserContants.userIdFront, idFront);
    await prefs.setString(UserContants.userIdBack, idBack);
    await prefs.setString(UserContants.userIdFront, idFront);
    await prefs.setString(UserContants.userIdFront, profilePhoto);
    await prefs.setString(UserContants.userGender, userGender.value);
  }

  Future<void> registerUser() async {
    isLoading.value = true;
    final url = Uri.parse('https://courier.hnktrecruitment.in/register');

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['name'] = userName;
      request.fields['email'] = userEmail;
      request.fields['company_name'] = companyName;
      request.fields['mobile_number'] = userPhone;
      request.fields['password'] = password;
      request.fields['confirm_password'] = password;
      request.fields['address'] = userAddress;
      request.fields['gender'] = userGender.value;

      request.files
          .add(await http.MultipartFile.fromPath('govt_id_front', userIdFront));
      request.files
          .add(await http.MultipartFile.fromPath('govt_id_back', userIdBack));
      request.files.add(
          await http.MultipartFile.fromPath('profile_photo', userProfilePhoto));

      final response = await request.send();
      var data = await response.stream.bytesToString();
      var jsonData = jsonDecode(data);

      if (response.statusCode == 200) {
        int userId = jsonData[UserContants.userId];
        await prefs.setInt(UserContants.userId, userId);
        await prefs.setString(UserContants.userProfilePhoto, userProfilePhoto);
        await prefs.setString(UserContants.userName, userName);
        Fluttertoast.showToast(
            msg: "Registration Successful", timeInSecForIosWeb: 20);
        registerStatus.value = 'success';
        Get.offAllNamed(AppRoutes.navBar);
      } else if (response.statusCode == 500) {
        String error = jsonData['error'];
        Fluttertoast.showToast(
            msg: '$error Try Again',
            timeInSecForIosWeb: 20,
            toastLength: Toast.LENGTH_LONG);
        registerStatus.value = 'error';
        Get.offAllNamed(AppRoutes.register);
      } else {
        String error = jsonData['error'];
        Fluttertoast.showToast(
            msg: "Registration Failed, $error", timeInSecForIosWeb: 20);
        registerStatus.value = 'error';
        Get.offAllNamed(AppRoutes.register);
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString(), timeInSecForIosWeb: 20);
    }
    isLoading.value = false;
  }

  Future<void> loginUser(String email, String password) async {
    LoginUserModel loginUserModel;
    isLoading.value = true;
    final url = Uri.parse('https://courier.hnktrecruitment.in/login');

    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      var jsonData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        loginUserModel = LoginUserModel.fromJson(jsonData);

        int userId = loginUserModel.userId!;
        String userName = loginUserModel.name!;
        String userProfileUrl = loginUserModel.profilePhotoUrl!;

        await prefs.setInt(UserContants.userId, userId);
        await prefs.setString(UserContants.userName, userName);
        await prefs.setString(UserContants.userProfilePhoto, userProfileUrl);

        Fluttertoast.showToast(msg: "Login Successful");
        Get.offNamed(AppRoutes.navBar);
      } else {
        Fluttertoast.showToast(msg: jsonData['error']);
      }
    } on Exception catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Error Occured, Check your internet connection and try again",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 20);
    }
    isLoading.value = false;
  }

  void startOtpResendTimer() {
    const int resendDelaySeconds = 60;
    otpResendTimer.value = resendDelaySeconds;
    isTimerRunning.value = true; // Timer starts, set the flag to true
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (otpResendTimer.value == 0) {
        timer.cancel();
        isTimerRunning.value = false; // Timer stops, set the flag to false
      } else {
        otpResendTimer.value--;
      }
    });
  }

  Future<void> setEmailOTPConfig(String email) async {
    isLoading.value = true;
    try {
      emailAuth2.setConfig(
          appEmail: "ziplinez53@gmail.com",
          appName: "ziplinez",
          userEmail: email,
          otpLength: 6,
          otpType: OTPType.digitsOnly);

      if (await emailAuth2.sendOTP() == true) {
        isEmailCodeSent.value = true;
        Fluttertoast.showToast(
            msg: "email OTP sent successfully", timeInSecForIosWeb: 10);

        // Get.toNamed(
        //     '${AppRoutes.otpEmail}?email=$userEmail'); // comment this line when phone otp is available.

        // await registerUser();
      } else {
        Fluttertoast.showToast(
            msg: "Email OTP Failed to send", timeInSecForIosWeb: 10);
      }
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Cant send email otp", timeInSecForIosWeb: 10);
    }
    isLoading.value = false;
  }

  Future<void> verifyEmailOTP2(String otp) async {
    isLoading.value = true;
    try {
      if (await emailAuth2.verifyOTP(otp: otp)) {
        isEmailVerified.value = true;
        Fluttertoast.showToast(
            msg: "Email OTP verified successfully", timeInSecForIosWeb: 10);
        await registerUser();
      } else {
        print('aaaaauth');
        Fluttertoast.showToast(
            msg: "Can't verify email OTP", timeInSecForIosWeb: 10);
      }
    } on Exception catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(msg: "Cant verify email otp");
    }
    isLoading.value = false;
  }

  Future<void> sendPhoneOTP(String phoneNumber) async {
    isLoading.value = true;
    isPhoneVerified.value = false;
    phoneOtpId = '';
    try {
      final url = Uri.parse('https://courier.hnktrecruitment.in/send-otp');
      final response = await http.post(url,
          body: jsonEncode({
            'mobile_number': phoneNumber,
          }),
          headers: {'Content-Type': 'application/json'});
      final jsonData = jsonDecode(response.body.toString());
      startOtpResendTimer();
      if (response.statusCode == 200) {
        phoneOtpId = jsonData['otp_id'].toString();
        Fluttertoast.showToast(
            msg: "Phone OTP sent Successfully", toastLength: Toast.LENGTH_LONG);
        Get.toNamed('${AppRoutes.otpMob}?phone=$userPhone');
      } else {
        Fluttertoast.showToast(
            msg: "An error occurred while sending phone OTP",
            toastLength: Toast.LENGTH_LONG);
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: "An error occurred while sending phone OTP",
          toastLength: Toast.LENGTH_LONG);
      isLoading.value = false;
    }

    isLoading.value = false;
  }

  Future<void> verifyPhoneOTP(String otp) async {
    isLoading.value = true;
    try {
      final url = Uri.parse('https://courier.hnktrecruitment.in/verify-otp');
      final response = await http.post(
        url,
        body: jsonEncode({
          'otp_id': phoneOtpId,
          'user_otp': otp,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final jsonData = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        String status = jsonData['status'];
        String msg = jsonData['message'];

        if (status == 'success') {
          Fluttertoast.showToast(
              msg: 'Phone OTP Verified Successfully',
              toastLength: Toast.LENGTH_LONG);
          isPhoneVerified.value = true;
          startOtpResendTimer();
          Get.offNamed('${AppRoutes.otpEmail}?email=$userEmail');
          setEmailOTPConfig(userEmail);
        } else if (status == 'error') {
          Fluttertoast.showToast(
              msg: 'Could\'nt verify OTP, please try again',
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'An error occurred, check you\'r internet and try again',
            toastLength: Toast.LENGTH_LONG);
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'An error occurred, check you\'r internet and try again',
          toastLength: Toast.LENGTH_LONG);
    }
    isLoading.value = false;
  }

  // Future<void> sendPhoneOTP(String phoneNumber) async {
  //   print('pppppp$phoneNumber');
  //   isLoading.value = true;
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: _verificationCompleted,
  //       verificationFailed: _verificationFailed,
  //       codeSent: _codeSent,
  //       codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
  //     );
  //     startOtpResendTimer();
  //   } on FirebaseAuthException catch (e) {
  //     Fluttertoast.showToast(msg: e.message.toString(), timeInSecForIosWeb: 30);
  //   }
  // }

  Future<void> resendPhoneOTP(String phoneNumber) async {
    await sendPhoneOTP(phoneNumber);
  }

  // Future<void> verifyPhoneOTP(String otp) async {
  //   isLoading.value = true;
  //   try {
  //     AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId.value,
  //       smsCode: otp,
  //     );
  //     await _signInWithCredential(credential);
  //   } catch (e) {
  //     isLoading.value = false;
  //     Fluttertoast.showToast(msg: "Phone OTP verification failed", timeInSecForIosWeb: 10);
  //     print("Verification Failed: $e");
  //   }
  // }

  void _codeAutoRetrievalTimeout(String verificationId) {
    isLoading.value = false;
    this.verificationId.value = verificationId;
    isPhoneCodeSent.value = true;
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    isPhoneCodeSent.value = true;
    await _signInWithCredential(credential);
    Fluttertoast.showToast(
        msg: "Phone OTP verified successfully", timeInSecForIosWeb: 10);
    // Get.toNamed('${AppRoutes.otpEmail}?email=$userEmail');
    // setEmailOTPConfig(userEmail);
    print('verification complete called ${isPhoneCodeSent.value}');
  }

  void _verificationFailed(FirebaseAuthException e) {
    isLoading.value = false;
    isPhoneCodeSent.value = false;
    print("Verification Failed: ${e.message}");
  }

  void _codeSent(String verificationId, int? resendToken) {
    isLoading.value = false;
    this.verificationId.value = verificationId;
    isPhoneCodeSent.value = true;
    this.resendToken = resendToken; // Store the resendToken
    Fluttertoast.showToast(
        msg: "Phone OTP sent successfully", timeInSecForIosWeb: 10);
    Get.toNamed('${AppRoutes.otpMob}?phone=$userPhone');
    print('code sent called ${isPhoneCodeSent.value}');
  }

  Future<void> _signInWithCredential(AuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      isLoading.value = false;
      print("User Verified: ${userCredential.user?.uid}");

      if (userCredential.user?.uid != null) {
        Fluttertoast.showToast(
            msg: "Phone OTP verified successfully", timeInSecForIosWeb: 10);
        isPhoneVerified.value = true;
        startOtpResendTimer();
        Get.offNamed('${AppRoutes.otpEmail}?email=$userEmail');
        setEmailOTPConfig(userEmail);
      }
    } catch (e) {
      isLoading.value = false;
      print("Sign In Failed: $e");
    }
  }
}
