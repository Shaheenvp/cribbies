import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../SignIn/login.dart';
import '../home/home.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SignUpViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (formKey.currentState!.validate()) {
        // Check if email and password are not empty
        if (email.isEmpty || password.isEmpty) {
          throw FirebaseAuthException(
            code: 'empty-input',
            message: 'Please enter email and password.',
          );
        }

        // Sign up the user with email and password
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          await FirebaseFirestore.instance.collection('users').add({
            'id': value.user?.uid,
            'email': email,
            'username': userNameController.text.trim(),
          });
        });

        // Navigate to the home screen after successful sign-up
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => Home()),
          (route) => false,
        );
      }
    } catch (e) {
      // Handle errors
      if (e is FirebaseAuthException) {
        String? errorMessage = e.message ?? 'An error occur';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else if (e.code == 'empty-input') {
          errorMessage = e.message;
        }
        // Show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign Up Error'),
              content: Text(errorMessage!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  /// Navigates to the androidLargeNineScreen when the action is triggered.
  onTapTxtSignIn(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }
}
