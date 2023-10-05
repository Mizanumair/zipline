import 'dart:convert';

import 'package:courier_app/src/features/auth/auth/preferences_service.dart';
import 'package:courier_app/src/features/features/all_item/all_orders_model.dart';
import 'package:courier_app/src/features/features/home/order_tracking_screen.dart';
import 'package:courier_app/src/features/features/item_details/complete_details.dart';
import 'package:courier_app/src/features/features/item_details/delivered%20_details.dart';
import 'package:courier_app/src/features/features/item_details/order_details_model.dart';
import 'package:courier_app/src/features/features/item_details/pending_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/user_constants.dart';

class HomeController extends GetxController {
  RxBool isSearchOrderLoading = false.obs;
  RxBool isLoading = false.obs;
  SharedPreferences prefs = PreferencesService.instance;
  RxList<AllOrdersModel> ordersList = RxList<AllOrdersModel>([]);

  Future<void> searchByOrderToken(String orderToken) async {
    isSearchOrderLoading.value = true;
    try {
      if (_validateOrderToken(orderToken)) {
        showProgressDialog();
        final url = Uri.parse('https://courier.hnktrecruitment.in/fetch-order-details/$orderToken');
        final response = await http.get(url);
        final data = response.body.toString();
        final jsonData = jsonDecode(data);
        if (response.statusCode == 200) {
          OrderDetailsModel order = OrderDetailsModel.fromJson(jsonData);
          String status = order.status.toString().toLowerCase();
          isSearchOrderLoading.value == false;
          Get.back();
          Get.to(() => OrderTrackingScreen(order: order));
        } else {
          Get.back();
          isSearchOrderLoading.value == false;
          Fluttertoast.showToast(msg: "Order with $orderToken token doesn't exist");
        }
      } else {
        Fluttertoast.showToast(msg: "Invalid token format");
      }
    } on Exception catch (e) {
      Get.back();
      isSearchOrderLoading.value == false;
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
    isSearchOrderLoading.value == false;
  }

  bool _validateOrderToken(String value) {
    return RegExp(r'^CRC\d+$', caseSensitive: false).hasMatch(value);
  }

  void showProgressDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<List<AllOrdersModel>> fetchRecentOrders() async {
    try {
      isLoading.value = true;
      final userId = prefs.getInt(UserContants.userId) ?? -1;
      final url = 'https://courier.hnktrecruitment.in/fetch-recent-user-orders/$userId';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Recent Fetched');
        final dynamic responseData = jsonDecode(response.body.toString());
        if (responseData is List) {
          final jsonData = jsonDecode(response.body.toString()) as List;
          final List<AllOrdersModel> orders = jsonData.map((item) => AllOrdersModel.fromJson(item)).toList();
          // Fluttertoast.showToast(msg: "Fetched Recent Orders", timeInSecForIosWeb: 20);
          ordersList.assignAll(orders);
        } else if (responseData is Map && responseData.containsKey('message')) {
          print('No data available: ${responseData['message']}');
          ordersList.clear();
        } else {
          print('Invalid response format.');
        }
      } else {
        Fluttertoast.showToast(
            msg: "Failed to load orders, Error Code: ${response.statusCode}", timeInSecForIosWeb: 20);
        ordersList.clear();
        print('Failed to load orders: ${response.statusCode}');
      }
    } on Exception catch (e) {
      ordersList.clear();
      Fluttertoast.showToast(msg: "Failed to load orders, Error: ${e.toString()}", timeInSecForIosWeb: 20);
    } finally {
      isLoading.value = false;
    }

    return ordersList;
  }
}
