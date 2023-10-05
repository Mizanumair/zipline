import 'package:courier_app/src/features/features/item_details/details_controller.dart';
import 'package:get/get.dart';

class DetailsBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<DetailsController>(DetailsController());
  }
}