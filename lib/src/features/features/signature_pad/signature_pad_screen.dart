import 'dart:io';
import 'dart:typed_data';
import 'package:courier_app/src/components/custom_appbar.dart';
import 'package:courier_app/src/components/custom_divider.dart';
import 'package:courier_app/src/components/custom_text_button.dart';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:courier_app/src/core/constants/strings.dart';
import 'package:courier_app/src/features/features/add_order/add_order_controller.dart';
import 'package:courier_app/src/features/features/home/home_controller.dart';
import 'package:courier_app/src/features/features/home/home_screen.dart';
import 'package:courier_app/src/features/features/signature_pad/signature_pad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../components/custom_button.dart';
import '../../../core/constants/palette.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class SignaturePadScreen extends GetView<SignaturePadController> {
  SignaturePadScreen({super.key});

  SignaturePadController controller = SignaturePadController();
  AddOrderController addOrderController = Get.put(AddOrderController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      //appBar: CustomAppBar(appBar: AppBar()),
      appBar: CustomAppbar(
        appBar: AppBar(),
        title: strSenderSign,
        containerColor: AppColors.transparent,
        text: '',
        color: AppColors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: margin_10),
          children: [
            CustomDivider(
              height: height_30,
              isDivider: false,
            ),
            Container(
              height: height_500,
              width: width_340,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.1),
                  borderRadius: BorderRadius.circular(radius_10),
                  border: Border.all(color: AppColors.white, width: 1.2, strokeAlign: BorderSide.strokeAlignOutside)),
              child: SfSignaturePad(
                strokeColor: AppColors.white,
                key: controller.signaturePadKey,
                backgroundColor: Colors.transparent,
                minimumStrokeWidth: width_3,
                maximumStrokeWidth: width_4,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin_140),
              child: CustomTextButton(
                  text: strClear,
                  color: AppColors.white,
                  fontWeight: fontWeight600,
                  font: font_13,
                  onPress: () {
                    controller.signaturePadKey.currentState!.clear();
                  }),
            ),
            CustomDivider(
              height: height_30,
              isDivider: false,
            ),
            Obx(
              () => addOrderController.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.orange,
                      ),
                    )
                  : CustomButton(
                      text: strAddSign,
                      color: AppColors.white,
                      fontWeight: fontWeight800,
                      font: font_16,
                      onPress: () async {
                        ui.Image image = await controller.signaturePadKey.currentState!.toImage();
                        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                        final Uint8List imageBytes =
                            byteData!.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
                        final String path = (await getApplicationSupportDirectory()).path;
                        final String fileName = '$path/output.png';

                        await File(fileName).writeAsBytes(imageBytes);
                        addOrderController.setSignatureFileName(fileName);
                        bool isSignatureAdded = await addOrderController.addItem();
                        if (isSignatureAdded) {
                          homeController.ordersList.refresh();
                          homeController.fetchRecentOrders();
                          Get.offAllNamed(AppRoutes.navBar);
                        }
                      },
                    ),
            ),
            CustomDivider(
              height: height_55,
              isDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
