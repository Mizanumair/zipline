import 'package:courier_app/src/components/custom_button.dart';
import 'package:courier_app/src/components/custom_container.dart';
import 'package:courier_app/src/components/custom_sender.dart';
import 'package:courier_app/src/components/custom_text.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:courier_app/src/features/features/item_details/details_controller.dart';
import 'package:courier_app/src/features/features/item_details/order_details_model.dart';
import 'package:courier_app/src/features/features/signature_pad/signature_reciever_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_senderr.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/strings.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderDetailsModel order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  DetailsController orderDetailsController = Get.put(DetailsController());

  Color buttonColor = AppColors.orange;
  String buttonTitle = 'Completed';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String status = widget.order.status.toString().toLowerCase();
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppbar(
        appBar: AppBar(),
        title: strItemDetail,
        containerColor: status == 'completed'
            ? AppColors.orange
            : status == 'delivered'
                ? AppColors.blue
                : status == 'pickup pending'
                    ? AppColors.yellow
                    : status == 'delivery pending'
                        ? AppColors.redColor
                        : AppColors.yellow,
        text: status == 'completed'
            ? strComplete
            : status == 'delivered'
                ? strDelivered
                : status == 'pickup pending'
                    ? strPickupPending
                    : 'Delivery Pending',
        color: AppColors.white,
        onPress: () {},
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: margin_15),
          children: [
            CustomDivider(
              height: height_25,
              isDivider: false,
            ),
            CustomSenderDetails(
              name: widget.order.senderName.toString(),
              contact: widget.order.senderContactNo.toString(),
              email: widget.order.senderEmailAddress.toString(),
              address: widget.order.senderAddress.toString(),
              heading: strAboutPack,
            ),
            CustomDivider(
              height: height_25,
              isDivider: false,
            ),
            CustomSenderDetails(
              name: widget.order.receiverName.toString(),
              contact: widget.order.receiverContactNo.toString(),
              email: widget.order.receiverEmailAddress.toString(),
              address: widget.order.receiverAddress.toString(),
              heading: strRecieverInfo,
            ),
            CustomDivider(
              height: height_25,
              isDivider: false,
            ),
            CustomSender(
                name: widget.order.itemName.toString(),
                size: widget.order.itemSize.toString(),
                imgText: widget.order.itemImageUrl.toString(),
                weight: widget.order.itemWeight.toString(),
                types: widget.order.itemType.toString(),
                category: widget.order.itemCategory.toString(),
                delivery: widget.order.deliveryRequired.toString(),
                charges: widget.order.charges.toString(),
                heading: strPackageDetails),
            CustomDivider(
              height: height_55,
              isDivider: false,
            ),
            widget.order.status.toString().toLowerCase() == 'pickup pending' ||
                    widget.order.status.toString().toLowerCase() ==
                        'delivery pending'
                ? Align(
                    heightFactor: 1.5,
                    alignment: Alignment.topLeft,
                    child: CustomText(
                        text: strTakeRecSign,
                        color1: AppColors.textWhite,
                        fontWeight: fontWeight600,
                        fontSize: font_15),
                  )
                : const SizedBox.shrink(),
            widget.order.status.toString().toLowerCase() == 'pickup pending' ||
                    widget.order.status.toString().toLowerCase() ==
                        'delivery pending'
                ? InkWell(
                    onTap: () {
                      Get.to(
                        () => SignatureRecieverScreen(
                            orderId: widget.order.orderId.toString()),
                      );
                    },
                    child: const CustomContainer(
                      title: strAddSign,
                      assetImage: AssetImage(ImgAssets.plus),
                    ),
                  )
                : const SizedBox.shrink(),
            widget.order.status.toString().toLowerCase() == 'pickup pending' ||
                    widget.order.status.toString().toLowerCase() ==
                        'delivery pending'
                ? CustomDivider(
                    height: height_25,
                    isDivider: false,
                  )
                : const SizedBox.shrink(),
            widget.order.status.toString().toLowerCase() == 'pickup pending' ||
                    widget.order.status.toString().toLowerCase() ==
                        'delivery pending'
                ? CustomButton(
                    text: strMarkAsComp,
                    color: AppColors.white,
                    fontWeight: fontWeight800,
                    font: font_16,
                    onPress: () {
                      Get.to(() => SignatureRecieverScreen(
                          orderId: widget.order.orderId.toString()));
                    },
                  )
                : const SizedBox.shrink(),
            widget.order.status.toString().toLowerCase() == 'pickup pending' ||
                    widget.order.status.toString().toLowerCase() ==
                        'delivery pending'
                ? CustomDivider(
                    height: height_65,
                    isDivider: false,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

/*

String orderStatus = snapshot.data!.status.toString();
        String orderId = snapshot.data!.orderId.toString();
    String senderName = snapshot.data!.senderName.toString();
    String senderContact = snapshot.data!.senderContactNo.toString();
    String senderEmail = snapshot.data!.senderEmailAddress.toString();
    String senderAddress = snapshot.data!.senderAddress.toString();
    String receiverName = snapshot.data!.receiverName.toString();
    String receiverContact = snapshot.data!.receiverContactNo.toString();
    String receiverEmail = snapshot.data!.receiverEmailAddress.toString();
    String receiverAddress = snapshot.data!.receiverAddress.toString();
    String itemName = snapshot.data!.itemName.toString();
    String itemImageUrl = snapshot.data!.itemImageUrl.toString();
    String itemSize = snapshot.data!.itemSize.toString();
    String itemWeight = snapshot.data!.itemWeight.toString();
    String itemType = snapshot.data!.itemType.toString();
    String itemCategory = snapshot.data!.itemCategory.toString();
    String itemDeliveryRequired = snapshot.data!.deliveryRequired.toString() == '1' ? 'Yes' : 'No';
    String itemCharges = snapshot.data!.charges.toString();


 */
