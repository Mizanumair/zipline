import 'package:courier_app/src/features/auth/auth/auth.dart';
import 'package:courier_app/src/features/auth/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}