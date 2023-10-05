import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/core/constants/font_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'calendar.dart';
import '../core/constants/palette.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.name,
    this.initialValue,
    this.labelText,
    this.labelColor = AppColors.black,
    this.textColor = AppColors.black,
    required this.fontSize,
    required this.fontWeight,
    required this.borderColor,
    this.borderWidth = 1,
    required this.radius,
    required this.inputType,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChanged,
    this.fillColor = AppColors.white,
    required this.options,
  }) : super(key: key);

  final AutovalidateMode autoValidateMode;
  final String name;
  final String? initialValue;
  final String? labelText;
  final Color labelColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final TextInputType inputType;
  final dynamic suffixIcon;
  final dynamic prefixIcon;

  final Function(String)? onChanged;
  final Color fillColor;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: name,
      icon: Icon(Icons.abc, color: AppColors.transparent),
      style: TextStyle(color: AppColors.orange, fontSize: font_13, fontWeight: fontWeight400),
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: labelColor,
          fontFamily: 'Mukta',
        ),
        hintText: labelText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: labelColor,
          fontFamily: 'Mukta',
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      initialValue: initialValue,
      items: options
          .map(
            (option) => DropdownMenuItem(
              alignment: AlignmentDirectional.topStart,
              value: option,
              child: Text(
                option,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                  fontFamily: 'Mukta',
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (val) => onChanged!(val!),
      valueTransformer: (val) => val?.toString(),
    );
  }
}
