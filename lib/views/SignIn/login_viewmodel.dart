import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../SignUp/SignUp.dart';
import '../home/home.dart';


class SignInViewModel extends BaseViewModel{

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Navigates to the androidLargeTwoScreen when the action is triggered.
  onTapLOGIN(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  /// Navigates to the androidLargeNineScreen when the action is triggered.
  onTapTxtSignUp(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

}