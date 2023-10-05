// import 'package:courier_app/src/components/custom_list.dart';
// import 'package:courier_app/src/components/custom_radio.dart';
// import 'package:courier_app/src/features/features/add_order/add_order_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../components/custom_appbar.dart';
// import '../../../components/custom_button.dart';
// import '../../../components/custom_divider.dart';
// import '../../../components/custom_text.dart';
// import '../../../components/custom_textfield.dart';
// import '../../../core/constants/assets.dart';
// import '../../../core/constants/dimensions.dart';
// import '../../../core/constants/font_weight.dart';
// import '../../../core/constants/palette.dart';
// import '../../../core/constants/strings.dart';
// import 'add_order4_screen.dart';
//
// class AddOrderScreen extends StatefulWidget {
//   const AddOrderScreen({super.key});
//
//   @override
//   State<AddOrderScreen> createState() => _AddOrderScreenState();
// }
//
// class _AddOrderScreenState extends State<AddOrderScreen> {
//   AddOrderController controller = Get.put(AddOrderController());
//
//   int _currentStep = 0;
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         appBar: AppBar(),
//         title: strItemDetail,
//         containerColor: AppColors.transparent,
//         text: '',
//         color: AppColors.transparent,
//       ),
//       body: Stepper(
//         currentStep: _currentStep,
//         type: StepperType.horizontal,
//         onStepTapped: (index) {
//           setState(() {
//             _currentStep = index;
//           });
//         },
//         steps: [
//           Step(
//             title: Text(''),
//             content: Text(''),
//             isActive: _currentStep >= 0,
//           ),
//           Step(
//             title: Text(''),
//             content: Text(''),
//             isActive: _currentStep >= 1,
//           ),
//           Step(
//             title: Text(''),
//             content: Text(''),
//             isActive: _currentStep >= 2,
//           ),
//           Step(
//             title: Text(''),
//             content: Text(''),
//             isActive: _currentStep >= 3,
//           ),
//         ],
//         elevation: 0,
//       ),
//     );
//   }
// }
