import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key,
    required this.text,
    required this.color1,
    required this.fontWeight,
    required this.fontSize,
    this.textAlign,

  }): super(key:key);

  final String text;
  final Color color1;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color1,
        fontFamily: 'Mukta',
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }
}
