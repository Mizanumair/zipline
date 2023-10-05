import 'dart:convert';

import 'package:courier_app/src/features/features/item_details/order_details_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailsController extends GetxController {
  RxBool isLoading = false.obs;

  Future<OrderDetailsModel?> getOrderDetailsByToken(String token) async {
    isLoading.value = true;
    OrderDetailsModel? orderDetails;
    final url = Uri.parse('https://courier.hnktrecruitment.in/fetch-order-details/$token');

    try {
      final response = await http.get(url);

      final data = response.body.toString();
      final jsonData = jsonDecode(data);

      if (response.statusCode == 200) {
        orderDetails = OrderDetailsModel.fromJson(jsonData);
        Fluttertoast.showToast(msg: "Order Details Fetched", timeInSecForIosWeb: 20);
      } else {
        Fluttertoast.showToast(
            msg: "Order Details Could Not Be Fetched, Error Code : ${response.statusCode}", timeInSecForIosWeb: 20);
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: "Checkout Your internet connection and try again, Error: ${e.toString()}", timeInSecForIosWeb: 20);
    }
    isLoading.value = false;
    return orderDetails;
  }
}
