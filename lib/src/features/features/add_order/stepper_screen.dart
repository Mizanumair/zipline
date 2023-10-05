// import 'package:courier_app/src/components/custom_appbar.dart';
// import 'package:courier_app/src/core/constants/dimensions.dart';
// import 'package:courier_app/src/core/constants/palette.dart';
// import 'package:courier_app/src/core/constants/strings.dart';
// import 'package:courier_app/src/features/features/add_order/add_order1_screen.dart';
// import 'package:courier_app/src/features/features/add_order/add_order2_screen.dart';
// import 'package:courier_app/src/features/features/add_order/add_order3_screen.dart';
// import 'package:courier_app/src/features/features/add_order/add_order4_screen.dart';
// import 'package:courier_app/src/features/features/add_order/add_order_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class StepperScreen extends StatelessWidget {
//   StepperScreen({super.key});
//
//   int _currentStep = 0;
//
//   final AddOrderController addOrderController = Get.put(AddOrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppbar(
//           appBar: AppBar(),
//           title: strItemDetail,
//           containerColor: AppColors.transparent,
//           text: '',
//           color: AppColors.transparent,
//         ),
//         body: Obx(
//           () => Column(
//             children: [
//               Container(
//                 width: double.infinity, //// Take full width of the screen
//                 height: height_70,
//                 decoration: BoxDecoration(
//                   color: AppColors.transparent,
//                 ),
//                 child: Stepper(
//                   currentStep: addOrderController.currentStep.value,
//                   type: StepperType.horizontal,
//                   steps: [
//                     Step(
//                       title: Text(''),
//                       content: Text(''),
//                       isActive: addOrderController.currentStep.value >= 0,
//                     ),
//                     Step(
//                       title: Text(''),
//                       content: Text(''),
//                       isActive: addOrderController.currentStep.value >= 1,
//                     ),
//                     Step(
//                       title: Text(''),
//                       content: Text(''),
//                       isActive: addOrderController.currentStep.value >= 2,
//                     ),
//                     Step(
//                       title: Text(''),
//                       content: Text(''),
//                       isActive: addOrderController.currentStep.value >= 3,
//                     ),
//                   ],
//                   elevation: 0,
//                   onStepTapped: (index) {
//                     if (addOrderController.isStepValid(index)) {
//                       addOrderController.currentStep.value = index;
//                     }
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildStepContent(addOrderController.currentStep.value),
//               )
//             ],
//           ),
//         ));
//   }
//
//   Widget _buildStepContent(int step) {
//     switch (step) {
//       case 0:
//         return const AddOrderOneScreen();
//       case 1:
//         return const AddOrderTwoScreen();
//       case 2:
//         return const AddOrderThreeScreen();
//       case 3:
//         return const AddOrderFourScreen();
//       default:
//         return Container();
//     }
//   }
// }
