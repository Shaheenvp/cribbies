import 'package:Potrack/utils/custom_snackBar.dart';
import 'package:Potrack/utils/navigation_service.dart';
import 'package:Potrack/views/purchaseOrder_page/purchaseOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../SignUp/SignUp.dart';
import '../home/home.dart';

class SignInViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> signIn(BuildContext context) async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Check if email and password are not empty
      if (formKey.currentState!.validate()) {
        if (email.isEmpty || password.isEmpty) {
          throw FirebaseAuthException(
            code: 'empty-input',
            message: 'Please enter email and password.',
          );
        }

        // Sign in the user with email and password
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userId', value.user!.uid);
        });

        showSnackBar(
            content: 'Logged In Successfully',
            context: context,
            color: Colors.green);
        // Navigate to the home screen after successful sign-in
        NavigationService.navigateRemoveUntil(context: context, screen: PurchaseOrder());
      }
    } catch (e) {
      // Handle errors
      if (e is FirebaseAuthException) {
        String? errorMessage = e.message ?? 'An error occur';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else if (e.code == 'empty-input') {
          errorMessage = e.message;
        }
        // Show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign In Error'),
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
  onTapTxtSignUp(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}
