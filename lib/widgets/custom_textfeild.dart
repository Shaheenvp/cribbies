import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? validateText;
  final IconData? icon;
  final bool obscureText;
  final double? height;
  final double? width;
  final IconData? suffixIcon;
  final TextStyle? labelTextStyle;
  final int maxLines;
  TextInputType? keyboardType;

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
    this.validateText,
    this.keyboardType,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validateText ?? 'Fill the Field';
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText ? _obscureText : false,
        maxLines: widget.maxLines,
        style: TextStyle(fontSize: 13), // Set the font size for entered values
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: widget.labelTextStyle,
          suffixIcon: widget.obscureText
              ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText
                ? Icons.visibility
                : Icons.visibility_off),
          )
              : null,
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.fromLTRB(
              16, widget.height != null ? (widget.height! - 20) / 2 : 10, 16, 0),
        ),
      ),
    );
  }
}
