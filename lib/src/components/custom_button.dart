import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key?key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.font,
    required this.onPress,
    this.buttonColor, this.width,
  }):super(key:key);


  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double font;
  final Function() onPress;
  final Color? buttonColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: width,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            buttonColor ?? AppColors.orange
          ),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius_10)
          ),),
          elevation: MaterialStatePropertyAll(0),

        ),
          child: CustomText(
            text: text,
            color1: color,
            fontWeight: fontWeight,
            fontSize: font,

          ),),
    );
  }
}
