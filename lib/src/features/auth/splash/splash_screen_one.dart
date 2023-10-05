import 'package:courier_app/src/core/constants/assets.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:courier_app/src/features/auth/splash/splash_controller.dart';
import 'package:courier_app/src/features/auth/splash/splash_screen_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashOneScreen extends StatefulWidget {
  const SplashOneScreen({super.key});

  @override
  State<SplashOneScreen> createState() => _SplashOneScreenState();
}

class _SplashOneScreenState extends State<SplashOneScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen(); // Start the navigation process
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Delay of 2 seconds
    Get.off(const SplashTwoScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Stack(
        children: [
         // Image(image: AssetImage(ImgAssets.splashbackone)),
          SizedBox(
              height: MediaQuery.of(context).size.height*1,
              width: MediaQuery.of(context).size.width*1,
              child: Image(image: AssetImage(ImgAssets.splashbackone),)),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: margin_15),
            child: Center(child: Image(image: AssetImage(ImgAssets.splashOne), )),
          ),
        ],
      ),
    );
  }
}
