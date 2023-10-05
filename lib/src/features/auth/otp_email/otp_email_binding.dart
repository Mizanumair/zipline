import 'package:courier_app/src/features/auth/otp_email/otp_email_controller.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';

class OtpEmailBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<AuthController>(AuthController());
  }
}