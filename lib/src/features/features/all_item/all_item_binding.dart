import 'package:courier_app/src/features/features/all_item/all_item_controller.dart';
import 'package:get/get.dart';

class AllItemBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<AllItemController>(AllItemController());
  }
}