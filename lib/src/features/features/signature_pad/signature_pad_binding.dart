import 'package:courier_app/src/features/features/signature_pad/signature_pad_controller.dart';
import 'package:get/get.dart';

class SignaturePadBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<SignaturePadController>(SignaturePadController());
  }
}