import 'dart:async';
import 'package:cribbies/views/SignIn/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => SignIn()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF6D5CA),
      body: Center(
        child: SizedBox(
            height: 170,
            child: Image(image: AssetImage('assets/cribbies_name.png'))),
        // child: Text('CRIBBIES',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
