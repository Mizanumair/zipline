import 'package:courier_app/src/features/auth/splash/splash_screen_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    _navigateToNextScreen(); // Start the navigation process
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2,)); // Delay of 2 seconds
    Get.off( SplashOneScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Stack(
       // reverse: true,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height*1,
              width: MediaQuery.of(context).size.width*1,
              child: Image(image: AssetImage(ImgAssets.splashbacktwo), )),
          Padding(
            padding:  EdgeInsets.only(top: margin_150, left: margin_60, right: margin_60),
            child: Image(image: AssetImage(ImgAssets.splashOne),),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              heightFactor: height_4,
              child: Image.asset(ImgAssets.scooter, height: height_120,)),
        ],
      ),
    );
  }
}

