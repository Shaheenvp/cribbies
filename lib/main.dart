import 'package:Potrack/splash.dart';
import 'package:Potrack/views/SignUp/SignUp.dart';
import 'package:Potrack/views/add_itempage/add_item.dart';
import 'package:Potrack/views/detail_page/detail_page.dart';
import 'package:Potrack/views/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Splash(),
        debugShowCheckedModeBanner: false,
    );
  }
}


