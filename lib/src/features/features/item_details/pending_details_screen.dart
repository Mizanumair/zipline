import 'package:courier_app/src/components/custom_button.dart';
import 'package:courier_app/src/components/custom_container.dart';
import 'package:courier_app/src/components/custom_sender.dart';
import 'package:courier_app/src/components/custom_text.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:courier_app/src/features/features/item_details/details_controller.dart';
import 'package:courier_app/src/features/features/item_details/order_details_model.dart';
import 'package:courier_app/src/features/features/signature_pad/signature_pad_controller.dart';
import 'package:courier_app/src/features/features/signature_pad/signature_reciever_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_senderr.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/strings.dart';

class PendingDetailsScreen extends StatefulWidget {
  final String orderToken;

  const PendingDetailsScreen({super.key, required this.orderToken});

  @override
  State<PendingDetailsScreen> createState() => _PendingDetailsScreenState();
}

class _PendingDetailsScreenState extends State<PendingDetailsScreen> {
  DetailsController orderDetailsController = Get.put(DetailsController());
  SignaturePadController signaturePadController = Get.put(SignaturePadController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppbar(
        appBar: AppBar(),
        title: strItemDetail,
        containerColor: AppColors.yellow,
        text: strPickupPending,
        color: AppColors.white,
        onPress: () {},
      ),
      body: SafeArea(
          child: FutureBuilder<OrderDetailsModel?>(
        future: orderDetailsController.getOrderDetailsByToken(widget.orderToken),
        builder: (BuildContext context, AsyncSnapshot<OrderDetailsModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
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
              String itemDeliveryRequired = snapshot.data!.deliveryRequired.toString();
              String itemCharges = snapshot.data!.charges.toString();

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: margin_15),
                children: [
                  CustomDivider(
                    height: height_25,
                    isDivider: false,
                  ),
                  CustomSenderDetails(
                    name: senderName,
                    contact: senderContact,
                    email: senderEmail,
                    address: senderAddress,
                    heading: strAboutPack,
                  ),
                  CustomDivider(
                    height: height_25,
                    isDivider: false,
                  ),
                  CustomSenderDetails(
                    name: receiverName,
                    contact: receiverContact,
                    email: receiverEmail,
                    address: receiverAddress,
                    heading: strRecieverInfo,
                  ),
                  CustomDivider(
                    height: height_25,
                    isDivider: false,
                  ),
                  CustomSender(
                      name: itemName,
                      size: itemSize,
                      imgText: itemImageUrl,
                      weight: itemWeight,
                      types: itemType,
                      category: itemCategory,
                      delivery: itemDeliveryRequired,
                      charges: itemCharges,
                      heading: strPackageDetails),
                  CustomDivider(
                    height: height_55,
                    isDivider: false,
                  ),
                  Align(
                    heightFactor: 1.5,
                    alignment: Alignment.topLeft,
                    child: CustomText(
                        text: strTakeRecSign, color1: AppColors.black, fontWeight: fontWeight600, fontSize: font_15),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => SignatureRecieverScreen(orderId: orderId),
                      );
                    },
                    child: const CustomContainer(
                      title: strAddSign,
                      assetImage: AssetImage(ImgAssets.plus),
                    ),
                  ),
                  CustomDivider(
                    height: height_25,
                    isDivider: false,
                  ),
                  CustomButton(
                    text: strMarkAsComp,
                    color: AppColors.white,
                    fontWeight: fontWeight800,
                    font: font_16,
                    onPress: () {
                      Get.to(() => SignatureRecieverScreen(orderId: orderId));
                    },
                  ),
                  CustomDivider(
                    height: height_65,
                    isDivider: false,
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Order Details Could could not be fetched'),
              );
            }
          } else {
            return const Center(
              child: Text('An Error Occurred'),
            );
          }
        },
      )),
    );
  }
}
