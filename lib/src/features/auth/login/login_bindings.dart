import 'package:get/get.dart';

import '../auth/auth.dart';
import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}