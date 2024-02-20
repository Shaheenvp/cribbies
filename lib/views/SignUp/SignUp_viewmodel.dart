import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../SignIn/login.dart';
import '../home/home.dart';


class SignUpViewModel extends BaseViewModel{

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();


  /// Navigates to the androidLargeTwoScreen when the action is triggered.
  onTapSignUp(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  /// Navigates to the androidLargeNineScreen when the action is triggered.
  onTapTxtSignIn(context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
  }


}