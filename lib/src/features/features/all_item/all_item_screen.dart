import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:courier_app/src/components/calendar.dart';
import 'package:courier_app/src/components/custom_headcard.dart';
import 'package:courier_app/src/components/custom_shipping_chip.dart';
import 'package:courier_app/src/core/constants/assets.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:courier_app/src/core/constants/strings.dart';
import 'package:courier_app/src/features/features/all_item/all_item_controller.dart';
import 'package:courier_app/src/features/features/all_item/all_orders_model.dart';
import 'package:courier_app/src/features/features/home/home_screen.dart';
import 'package:courier_app/src/features/features/item_details/delivered%20_details.dart';
import 'package:courier_app/src/features/features/item_details/delivery_pending.dart';
import 'package:courier_app/src/features/features/item_details/pending_details_screen.dart';
import 'package:courier_app/src/features/features/signature_pad/signature_pad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../components/custom_appbar.dart';
import '../../../components/custom_list.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../item_details/complete_details.dart';

List<DateTime?> startEndDateList = [];

class AllItemScreen extends StatefulWidget {
  final String selectedStatus;
  late var initialIndex;
  bool navigatedFromNavBar;

  AllItemScreen({Key? key, this.selectedStatus = 'All', this.navigatedFromNavBar = false}) : super(key: key);

  @override
  State<AllItemScreen> createState() => _AllItemScreenState();
}

class _AllItemScreenState extends State<AllItemScreen> {
  AllItemController allItemsController = Get.put(AllItemController());
  SignaturePadController signatureController = Get.put(SignaturePadController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    widget.initialIndex = allItemsController.statuses.indexOf(widget.selectedStatus);
    print('initial 1');

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allItemsController.selectedStatus = widget.selectedStatus;
      print('initial 1 init');
      if (allItemsController.selectedStatus == 'All') {
        print('initial 1 if');
        allItemsController.fetchAllOrders();
      } else {
        print('initial 1 else');
        allItemsController.fetchOrdersByStatus(widget.selectedStatus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppbar(
        appBar: AppBar(),
        dontShowBackButton: widget.navigatedFromNavBar,
        title: strAllItem,
        containerColor: AppColors.transparent,
        text: '',
        color: AppColors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_10),
        children: [
          DefaultTabController(
            length: 5,
            initialIndex: widget.initialIndex,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  contentPadding: EdgeInsets.symmetric(horizontal: margin_10),
                  backgroundColor: AppColors.orange,
                  borderColor: AppColors.orange,
                  borderWidth: 2,
                  unselectedBackgroundColor: AppColors.transparent,
                  unselectedBorderColor: AppColors.orange,
                  unselectedLabelStyle: const TextStyle(color: AppColors.orange),
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  onTap: (index) {
                    searchController.clear();
                    // Fetch orders based on the selected tab
                    allItemsController.selectedStatus = allItemsController.statuses[index];
                    allItemsController.callFunctions();
                  },
                  tabs: const [
                    Tab(
                      text: strAll,
                    ),
                    Tab(
                      text: strComplete,
                    ),
                    Tab(
                      text: strDelivered,
                    ),
                    Tab(
                      text: strPickupPending,
                    ),
                    Tab(
                      text: 'Delivery Pending',
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height_10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height_45,
                        width: width_200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.greyColor.withOpacity(.5),
                            ),
                            borderRadius: BorderRadius.circular(radius_10)),
                        child: searchF(
                            suffix: ImgAssets.searchIcon,
                            controller: searchController,
                            onTap: () async {
                              await allItemsController.searchByOrderToken(searchController.text);
                              searchController.clear();
                            }),
                      ),
                      Container(
                        //height: height_60,
                        width: width_130,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(radius_10)),
                        child: CustomDropdown(
                          name: 'item type',
                          // labelText: strSelectItemType,
                          labelColor: AppColors.textWhite,
                          fontSize: font_13,
                          fontWeight: fontWeight400,
                          radius: radius_10,
                          inputType: TextInputType.name,
                          textColor: AppColors.greyColor,
                          fillColor: AppColors.greyColor.withOpacity(.3),
                          borderColor: AppColors.transparent,
                          suffixIcon: Image(
                            image: const AssetImage(ImgAssets.drop),
                            height: height_10,
                          ),
                          // prefixIcon: Image(image: AssetImage(ImgAssets.transparent), height: height_10,),
                          options: allItemsController.dropdownItems,
                          initialValue: 'Duration',
                          onChanged: (String? newValue) async {
                            if (newValue == 'Clear Filter') {
                              allItemsController.setSelectedDate = '';
                            } else if (newValue == 'Duration') {
                            } else if (newValue == 'Custom Day') {
                              await _showDatePickerDialog();
                              final dateStart = _getValueText(CalendarDatePicker2Type.range, startEndDateList, true);
                              final dateEnd = _getValueText(CalendarDatePicker2Type.range, startEndDateList, false);
                              print("${dateStart.trim()}:${dateEnd.trim()}");
                              allItemsController.setSelectedDate = "${dateStart.trim()}:${dateEnd.trim()}";
                            } else {
                              allItemsController.setSelectedDate = newValue!;
                            }
                            print('pado');
                            allItemsController.callFunctions();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height_470,
                  width: width_340,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      for (int i = 0; i < 5; i++)
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius_10)),
                          child: Obx(() {
                            print('built');
                            final List<AllOrdersModel> orders = allItemsController.ordersList;
                            final value = allItemsController.isUpdated.value;
                            return allItemsController.isLoading.isTrue
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: AppColors.orange,
                                  ))
                                : ListView.builder(
                                    itemCount: orders.length,
                                    itemBuilder: (context, index) {
                                      AllOrdersModel order = orders[index];
                                      String orderToken = order.orderToken.toString();
                                      String senderName = order.senderName.toString();
                                      String receiverName = order.receiverName.toString();
                                      String productName = order.itemName.toString();
                                      String dateAndTime = order.date.toString();
                                      String status = order.status.toString();
                                      String productImageUrl = order.itemImageUrl.toString();
                                      Color buttonColor;
                                      Color bgColor = AppColors.white;

                                      if (status.toLowerCase() == 'pickup pending') {
                                        buttonColor = AppColors.yellow;
                                      } else if (status.toLowerCase() == 'completed') {
                                        buttonColor = AppColors.orange;
                                      } else if (status.toLowerCase() == 'delivered') {
                                        buttonColor = AppColors.blue;
                                      } else {
                                        buttonColor = AppColors.redColor;
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: () {
                                            if (status.toLowerCase() == 'completed') {
                                              Get.to(() => CompleteOrdersScreen(
                                                    orderToken: orderToken,
                                                  ));
                                            } else if (status.toLowerCase() == 'delivered') {
                                              Get.to(() => DeliveredOrdersScreen(
                                                    orderToken: orderToken,
                                                  ));
                                            } else if (status.toLowerCase() == 'pickup pending') {
                                              Get.to(() => PendingDetailsScreen(
                                                    orderToken: orderToken,
                                                  ));
                                            } else if (status.toLowerCase() == 'delivery pending') {
                                              Get.to(() => DeliveryPendingScreen(orderToken: orderToken));
                                            }
                                          },
                                          child: ShippingChip(
                                            orderUidNo: orderToken,
                                            senderName: senderName,
                                            recieverName: receiverName,
                                            productName: productName,
                                            time: dateAndTime,
                                            buttonColor: buttonColor,
                                            buttonName: status,
                                            productImageUrl: productImageUrl,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          }),
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showDatePickerDialog() async {
    List<DateTime?> _dialogCalendarPickerValue = [
      DateTime.now(),
      DateTime.now().add(const Duration(days: 5)),
    ];
    const dayTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle = TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppColors.orange,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      value: _dialogCalendarPickerValue,
      dialogBackgroundColor: Colors.white,
    );

    if (values != null) {
      // print(_getValueText(config.calendarType, values, true));
      setState(() {
        _dialogCalendarPickerValue = values;
        startEndDateList = values;
      });
    }
  }
}

String _getValueText(
  CalendarDatePicker2Type datePickerType,
  List<DateTime?> values,
  bool start,
) {
  values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
  var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

  if (datePickerType == CalendarDatePicker2Type.range && start == true) {
    if (values.isNotEmpty) {
      final startDate = values[0].toString().replaceAll('00:00:00.000', '');
      final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
      valueText = startDate;
    } else {
      return 'null';
    }
  } else {
    if (values.isNotEmpty) {
      final startDate = values[0].toString().replaceAll('00:00:00.000', '');
      final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
      valueText = endDate;
    } else {
      return 'null';
    }
  }

  return valueText;
}

// class AllItemScreen extends GetView<AllItemController> {
//   AllItemScreen({super.key});
//
//   AllItemController allItemsController = Get.put(AllItemController());
//
//
// }

// Obx(() => allItemsController.isLoading.isTrue
//         ? const Center(
//             child: CircularProgressIndicator(
//             color: AppColors.orange,
//           ))
//         : ListView.builder(
//             itemCount: allItemsController.ordersList.length,
//             itemBuilder: (context, index) {
//               AllOrdersModel order = allItemsController.ordersList[index];
//               String orderToken = order.orderToken.toString();
//               String senderName = order.senderName.toString();
//               String receiverName = order.receiverName.toString();
//               String productName = order.itemName.toString();
//               String dateAndTime = order.date.toString();
//               String status = order.status.toString();
//               Color buttonColor;
//               Color bgColor = AppColors.white;
//
//               if (status.toLowerCase() == 'pickup pending') {
//                 buttonColor = AppColors.yellow;
//               } else if (status.toLowerCase() == 'completed') {
//                 buttonColor = AppColors.orange;
//               } else {
//                 buttonColor = AppColors.blue;
//               }
//
//               return Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: InkWell(
//                   onTap: () {
//                     Get.to(const CompleteOrdersScreen());
//                   },
//                   child: ShippingChip(
//                     orderUidNo: orderToken,
//                     senderName: senderName,
//                     recieverName: receiverName,
//                     productName: productName,
//                     time: dateAndTime,
//                     buttonColor: buttonColor,
//                     buttonName: status,
//                     bgColor: bgColor,
//                   ),
//                 ),
//               );
//             },
//           )
//     // Column(
//     //         children: [
//     //           InkWell(
//     //             onTap: () {
//     //               Get.to(const CompleteOrdersScreen());
//     //             },
//     //             child: const ShippingChip(
//     //               orderUidNo: '#CG5462JI',
//     //               senderName: 'Mack Smith',
//     //               recieverName: 'Mizan Umair',
//     //               productName: 'Flower Vase',
//     //               time: 'Mar 16, 2023 / 05:47 PM',
//     //               buttonColor: AppColors.orange,
//     //               buttonName: strComplete,
//     //               bgColor: AppColors.white,
//     //             ),
//     //           ),
//     //           const ShippingChip(
//     //             orderUidNo: '#CG5462JI',
//     //             senderName: 'Mack Smith',
//     //             recieverName: 'Mizan Umair',
//     //             productName: 'Flower Vase',
//     //             time: 'Mar 16, 2023 / 05:47 PM',
//     //             buttonColor: AppColors.blue,
//     //             buttonName: strDelivered,
//     //             bgColor: AppColors.white,
//     //           ),
//     //           InkWell(
//     //             onTap: () {
//     //               Get.to(PendingDetailsScreen());
//     //             },
//     //             child: ShippingChip(
//     //               orderUidNo: '#CG5462JI',
//     //               senderName: 'Mack Smith',
//     //               recieverName: 'Mizan Umair',
//     //               productName: 'Flower Vase',
//     //               time: 'Mar 16, 2023 / 05:47 PM',
//     //               buttonColor: AppColors.yellow,
//     //               buttonName: strPickupPending,
//     //               bgColor: AppColors.white,
//     //             ),
//     //           ),
//     //           for (int i = 0; i < 10; i++)
//     //             ShippingChip(
//     //               orderUidNo: '#CG5462JI',
//     //               senderName: 'Mack Smith',
//     //               recieverName: 'Mizan Umair',
//     //               productName: 'Flower Vase',
//     //               time: 'Mar 16, 2023 / 05:47 PM',
//     //               buttonColor: AppColors.redColor,
//     //               buttonName: strDelPending,
//     //               bgColor: AppColors.white,
//     //             ),
//     //         ],
//     //       ),
//     ),

//future builder

// FutureBuilder<List<AllOrdersModel>>(
//   future: allItemsController.fetchAllOrders(),
//   builder: (BuildContext context, AsyncSnapshot<List<AllOrdersModel>> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(
//         child: CircularProgressIndicator(
//           color: AppColors.orange,
//         ),
//       );
//     } else if (snapshot.hasData) {
//       return ListView.builder(
//         itemCount: allItemsController.ordersList.length,
//         itemBuilder: (context, index) {
//           AllOrdersModel order = allItemsController.ordersList[index];
//           String orderToken = order.orderToken.toString();
//           String senderName = order.senderName.toString();
//           String receiverName = order.receiverName.toString();
//           String productName = order.itemName.toString();
//           String dateAndTime = order.date.toString();
//           String status = order.status.toString();
//           Color buttonColor;
//           Color bgColor = AppColors.white;
//
//           if (status.toLowerCase() == 'pickup pending') {
//             buttonColor = AppColors.yellow;
//           } else if (status.toLowerCase() == 'completed') {
//             buttonColor = AppColors.orange;
//           } else {
//             buttonColor = AppColors.blue;
//           }
//
//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: InkWell(
//               onTap: () {
//                 Get.to(const CompleteOrdersScreen());
//               },
//               child: ShippingChip(
//                 orderUidNo: orderToken,
//                 senderName: senderName,
//                 recieverName: receiverName,
//                 productName: productName,
//                 time: dateAndTime,
//                 buttonColor: buttonColor,
//                 buttonName: status,
//                 bgColor: bgColor,
//               ),
//             ),
//           );
//         },
//       );
//     } else {
//       return const Center(
//         child: Text('An Error Occurred'),
//       );
//     }
//   },
// ),
