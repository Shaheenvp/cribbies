import 'package:cribbies/views/SignIn/login.dart';
import 'package:cribbies/views/SignUp/SignUp_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/customFloatingButton.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textfeild.dart';
import '../home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return ViewModelBuilder<SignUpViewModel>.reactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.formKey,
          child: Scaffold(
              floatingActionButton: CustomFloatingButton(
                onTap: () => viewModel.signUp(context),
                text: 'Sign Up',
              ),
              // resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: h * .13),
                  const SizedBox(
                      height: 110,
                      child:
                          Image(image: AssetImage('assets/cribbies_logo.png'))),
                  SizedBox(height: h * 0.05),

                  CustomTextFormField(
                    controller: viewModel.userNameController,
                    labelText: 'Enter Name',
                    icon: null,
                    height: h * 0.047,
                    width: w * 0.85,
                  ),
                  SizedBox(height: h * 0.03),
                  // Padding(
                  //   padding: EdgeInsets.only(right: w * .66),
                  //   child: const Text("Email", style: TextStyle(fontSize: 12.98)),
                  // ),
                  CustomTextFormField(
                    controller: viewModel.emailController,
                    labelText: 'Enter Email',
                    icon: null,
                    height: h * 0.047,
                    width: w * 0.85,
                  ),
                  SizedBox(height: h * 0.03),
                  // Padding(
                  //   padding: EdgeInsets.only(right: w * .66),
                  //   child:
                  //       const Text("Password", style: TextStyle(fontSize: 12.98)),
                  // ),
                  // const SizedBox(height: 6),
                  CustomTextFormField(
                    height: h * 0.047,
                    width: w * 0.85,
                    controller: viewModel.passwordController,
                    obscureText: true,
                    labelText: 'Enter Password',
                    icon: CupertinoIcons.eye,
                  ),
                  SizedBox(height: h * 0.05),
                  // SizedBox(height: 51),

                  // Spacer(flex: 61),
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
                                  viewModel.onTapTxtSignIn(context);
                                },
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ))
                          ])),
                  SizedBox(height: h * .13),
                ]),
              )),
        );
      },
      viewModelBuilder: () {
        return SignUpViewModel();
      },
    );
  }
}
