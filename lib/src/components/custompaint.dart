import 'package:courier_app/src/features/features/add_order/add_order1_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/constants/palette.dart';

class FloatingBtn extends StatefulWidget {
  const FloatingBtn({super.key});

  @override
  State<FloatingBtn> createState() => _FloatingBtnState();
}

class _FloatingBtnState extends State<FloatingBtn> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: AppColors.white,
      child: FloatingActionButton(onPressed: (){},
      backgroundColor: AppColors.orange,
        elevation: 0,
        child: IconButton(onPressed: (){
          Get.to(AddOrderOneScreen());
        },icon: Icon(Icons.add, color: AppColors.white,)),
      ),
    );
  }
}
