import 'package:courier_app/src/features/auth/forgot_password/forgot_password_controller.dart';
import 'package:courier_app/src/features/auth/forgot_password2/forgot_password_2_controller.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';

class ForgotPassword2Binding implements Bindings {
  @override
  void dependencies() {
    Get.put<ForgotPassword2Controller>(ForgotPassword2Controller());
  }
}
