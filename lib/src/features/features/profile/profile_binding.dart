import 'package:courier_app/src/features/features/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<ProfileController>(ProfileController());
  }
}