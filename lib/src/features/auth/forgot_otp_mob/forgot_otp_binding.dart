import 'package:courier_app/src/features/auth/auth/auth.dart';
import 'package:get/get.dart';

class ForgotOtpMobBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
