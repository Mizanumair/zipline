import 'package:courier_app/src/features/auth/new_password/new_password_controller.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';

class NewPasswordBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<AuthController>(AuthController());
  }
}