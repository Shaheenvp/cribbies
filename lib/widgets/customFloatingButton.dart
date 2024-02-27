import 'package:flutter/material.dart';

import '../main.dart';

class CustomFloatingButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CustomFloatingButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 0.91,
        height: w * 0.15,
        decoration: BoxDecoration(
            color: Color(0xffF6D5CA),
            borderRadius: BorderRadius.circular(w * 0.04)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
