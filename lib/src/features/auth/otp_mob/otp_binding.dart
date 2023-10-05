import 'package:courier_app/src/features/auth/otp_mob/otp_controller.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';

class OtpMobBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<AuthController>(AuthController());
  }
}