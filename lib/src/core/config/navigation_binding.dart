import 'package:courier_app/src/core/config/navigation_controller.dart';
import 'package:get/get.dart';

class NavBarBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<NavigationController>(NavigationController());
  }
}