import 'package:courier_app/src/features/features/add_order/add_order_controller.dart';
import 'package:get/get.dart';

class AddOrderBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<AddOrderController>(AddOrderController());
  }
}