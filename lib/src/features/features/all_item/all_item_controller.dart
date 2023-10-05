import 'dart:convert';

import 'package:courier_app/src/core/constants/user_constants.dart';
import 'package:courier_app/src/features/features/home/order_tracking_screen.dart';
import 'package:courier_app/src/features/features/item_details/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:courier_app/src/features/auth/auth/preferences_service.dart';
import 'package:courier_app/src/features/features/all_item/all_orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllItemController extends GetxController {
  @override
  // void onInit() {
  //   super.onInit();
  //   fetchAllOrders();
  // }

  final RxList<String> dropdownItems = RxList(['Duration', 'Today', '7 Days', 'Custom Day', 'Clear Filter']);

  final List<String> statuses = ['All', 'Completed', 'Delivered', 'Pickup Pending', 'Delivery Pending'];

  final RxBool isLoading = false.obs;
  RxList<AllOrdersModel> ordersList = RxList<AllOrdersModel>([]);
  SharedPreferences prefs = PreferencesService.instance;

  String selectedStatus = 'All';
  RxString selectedDate = ''.obs;
  RxString isUpdated = ''.obs;

  set setSelectedDate(value) {
    selectedDate.value = value;
    update(); // This triggers UI update
  }

  void callFunctions() {
    if (selectedStatus == 'All' && selectedDate.isEmpty) {
      fetchAllOrders();
    } else if (selectedStatus == 'All' && selectedDate.isNotEmpty) {
      fetchOrdersByDate(selectedDate.value);
    } else if (selectedStatus != 'All' && selectedDate.isNotEmpty) {
      fetchOrdersByStatusAndDate(selectedStatus, selectedDate.value);
    } else {
      print('Selected Status : $selectedStatus');
      fetchOrdersByStatus(selectedStatus);
    }
  }

  Future<void> searchByOrderToken(String orderToken) async {
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
          Get.back();
          Get.to(() => OrderTrackingScreen(order: order));
        } else {
          Get.back();
          Fluttertoast.showToast(msg: "Order with $orderToken token doesn't exist");
        }
      } else {
        Fluttertoast.showToast(msg: "Invalid token format");
      }
    } on Exception catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
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

  Future<List<AllOrdersModel>> fetchAllOrders() async {
    try {
      isLoading.value = true;
      final userId = prefs.getInt(UserContants.userId) ?? -1;
      final url = 'https://courier.hnktrecruitment.in/fetch-user-orders/$userId';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('All Orders Fetched testing');

        final dynamic responseData = jsonDecode(response.body.toString());
        if (responseData is List) {
          final jsonData = jsonDecode(response.body.toString()) as List;
          final List<AllOrdersModel> orders = jsonData.map((item) => AllOrdersModel.fromJson(item)).toList();
          // Fluttertoast.showToast(msg: "All Orders Fetched", timeInSecForIosWeb: 20);
          ordersList.assignAll(orders);
        } else if (responseData is Map && responseData.containsKey('message')) {
          // print('No data available: ${responseData['message']}');
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

  Future<void> fetchOrdersByStatus(String status) async {
      isLoading.value = true;
    try {
      final userId = prefs.getInt(UserContants.userId) ?? -1;

      final baseUrl = 'https://courier.hnktrecruitment.in/fetch-user-orders/$userId/$status';
      print('base url $baseUrl');
    print('status testing == $status');
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {

        final dynamic responseData = jsonDecode(response.body.toString());
        print('true');
        if (responseData is List) {
          print('true');
          final jsonData = jsonDecode(response.body.toString()) as List;
          final List<AllOrdersModel> orders = jsonData.map((item) {
            print(' uzair ${AllOrdersModel.fromJson(item).status}');
            return AllOrdersModel.fromJson(item);
          }).toList();
          ordersList.assignAll(orders);
          print('ashter ${ordersList.length}');
          ordersList.refresh();
          // Fluttertoast.showToast(msg: "$status Orders Fetched Successfully", timeInSecForIosWeb: 20);
        } else if (responseData is Map && responseData.containsKey('message')) {
          // Fluttertoast.showToast(msg: responseData['message']);
          ordersList.clear();
        } else {
          print('Invalid response format.');
        }
      } else {
        Fluttertoast.showToast(
            msg: "Failed to load orders, Error Code: ${response.statusCode}", timeInSecForIosWeb: 20);
        print('Failed to load delivered orders: ${response.statusCode}');
        ordersList.clear();
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "Failed to load orders, Error: ${e.toString()}", timeInSecForIosWeb: 20);
      ordersList.clear();
    }
      isLoading.value = false;
  }

  Future<void> fetchOrdersByDate(String date) async {
    print('datee + $date');
    try {
      isLoading.value = true;
      final userId = prefs.getInt(UserContants.userId) ?? -1;
      final baseUrl = 'https://courier.hnktrecruitment.in/fetch-user-orders/$userId/date/$date';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body.toString());
        if (responseData is List) {
          // Fluttertoast.showToast(msg: ' Orders for $date Fetched');
          print('date Orders for $date Fetched');

          final jsonData = jsonDecode(response.body.toString()) as List;
          final List<AllOrdersModel> orders = jsonData.map((item) => AllOrdersModel.fromJson(item)).toList();
          ordersList.assignAll(orders);
        } else if (responseData is Map && responseData.containsKey('message')) {
          Fluttertoast.showToast(msg: responseData['message']);
          ordersList.clear(); // Clea
        } else {
          print('Invalid response format.');
        }
      } else {
        Fluttertoast.showToast(
            msg: "Failed to load orders, Error Code: ${response.statusCode}", timeInSecForIosWeb: 20);
        ordersList.clear();
        print('Failed to load orders by date: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load orders, Error: ${e.toString()}", timeInSecForIosWeb: 20);
      ordersList.clear();
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrdersByStatusAndDate(String status, String date) async {
    print('$status orders for $date ');
    try {
      isLoading.value = true;
      final userId = prefs.getInt(UserContants.userId) ?? -1;
      String url = 'https://courier.hnktrecruitment.in/fetch-user-orders/$userId/status/$status/date/$date';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body.toString());
        if (responseData is List) {
          print('$status orders for $date fetched');
          final jsonData = jsonDecode(response.body.toString()) as List;
          final List<AllOrdersModel> orders = jsonData.map((item) => AllOrdersModel.fromJson(item)).toList();
          // Fluttertoast.showToast(msg: "$status Orders for $date Fetched Successfully", timeInSecForIosWeb: 20);
          ordersList.assignAll(orders);
        } else if (responseData is Map && responseData.containsKey('message')) {
          Fluttertoast.showToast(msg: responseData['message']);
          ordersList.clear(); // Clear the previous data, if any
        } else {
          print('Invalid response format.');
        }
      } else {
        Fluttertoast.showToast(msg: "Failed to load orders, Error: ${response.statusCode}", timeInSecForIosWeb: 20);
        ordersList.clear();
        print('Failed to load orders by status and date: ${response.statusCode}');
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "Failed to load orders, Error: ${e.toString()}", timeInSecForIosWeb: 20);
      ordersList.clear();
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
