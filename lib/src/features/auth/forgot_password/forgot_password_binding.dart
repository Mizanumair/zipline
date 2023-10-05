import 'package:courier_app/src/features/auth/forgot_password/forgot_password_controller.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
