import 'package:cribbies/views/SignIn/login_viewmodel.dart';
import 'package:cribbies/widgets/custom_textfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/customFloatingButton.dart';
import '../SignUp/SignUp.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return ViewModelBuilder<SignInViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.formKey,
          child: SafeArea(
              child: Scaffold(
                  floatingActionButton: CustomFloatingButton(
                    text: 'Sign In',
                    onTap: () => viewModel.signIn(context),
                  ),
                  body: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(height: h * .15),
                      const SizedBox(
                          height: 110,
                          child: Image(
                              image: AssetImage('assets/cribbies_logo.png'))),
                      Padding(
                        padding: EdgeInsets.only(right: w * .67),
                        child: Text("Email", style: TextStyle(fontSize: 12.98)),
                      ),
                      const SizedBox(height: 6),
                      CustomTextFormField(
                        controller: viewModel.emailController,
                        labelText: '',
                        validateText: 'Please Enter Email',
                        icon: null,
                        height: h * 0.047,
                        width: w * 0.85,
                      ),
                      SizedBox(height: h * .03),
                      Padding(
                        padding: EdgeInsets.only(right: w * .67),
                        child: const Text("Password",
                            style: TextStyle(fontSize: 12.98)),
                      ),
                      CustomTextFormField(
                        validateText: 'Please Enter Password',
                        height: h * 0.047,
                        width: w * 0.85,
                        suffixIcon: Icons.remove_red_eye_rounded,
                        controller: viewModel.passwordController,
                        obscureText: true,
                        labelText: '',
                        icon: CupertinoIcons.eye,
                      ),
                      SizedBox(height: h * .08),
                      // SizedBox(height: h * .15),
                      Padding(
                          padding: EdgeInsets.only(
                            bottom: h * .04,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don’t have an account ? ",
                                    style: TextStyle()),
                                InkWell(
                                    onTap: () {
                                      viewModel.onTapTxtSignUp(context);
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ))
                              ])),
                      SizedBox(height: h * .15),
                    ]),
                  ))),
        );
      },
      viewModelBuilder: () {
        return SignInViewModel();
      },
    );
  }
}
