import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;
  final bool obscureText;
  final double? height;
  final double? width;
  final IconData? suffixIcon;
  final TextStyle? labelTextStyle;
  final int maxLines;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.icon,
    this.obscureText = false,
    this.height,
    this.width,
    this.suffixIcon,
    this.labelTextStyle,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        style: TextStyle(fontSize: 13), // Set the font size for entered values
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelTextStyle,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.fromLTRB(16, height != null ? (height! - 20) / 2 : 10, 16, 0),
        ),
      ),
    );
  }
}
