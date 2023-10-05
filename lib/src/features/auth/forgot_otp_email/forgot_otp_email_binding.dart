import 'package:courier_app/src/features/auth/auth/auth.dart';

import 'package:get/get.dart';


class ForgotOtpEmailBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<AuthController>(AuthController());
  }
}