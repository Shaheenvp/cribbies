import 'package:cribbies/splash.dart';
import 'package:cribbies/views/SignIn/login.dart';
import 'package:cribbies/views/SignUp/SignUp.dart';
import 'package:cribbies/views/add_itempage/add_item.dart';
import 'package:cribbies/views/detail_page/detail_page.dart';
import 'package:cribbies/views/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
