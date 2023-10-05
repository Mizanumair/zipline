import 'package:courier_app/src/features/auth/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings{
@override
  void dependencies(){
  Get.put<SplashController>(SplashController(),permanent: true);
}
}