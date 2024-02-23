import 'package:flutter/material.dart';

showSnackBar(
    {required String content,
    required BuildContext context,
    required Color color}) {
  final snackBar = SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(
          letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
