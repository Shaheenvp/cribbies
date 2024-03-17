import 'package:Potrack/views/SignIn/login.dart';
import 'package:Potrack/views/SignUp/SignUp_viewmodel.dart';
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
              // floatingActionButton: CustomFloatingButton(
              //   onTap: () => viewModel.signUp(context),
              //   text: 'Sign Up',
              // ),
              // resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                    children: [
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
                  CustomTextFormField(
                    controller: viewModel.emailController,
                    labelText: 'Enter Email',
                    icon: null,
                    height: h * 0.047,
                    width: w * 0.85,
                  ),
                  SizedBox(height: h * 0.03),
                  CustomTextFormField(
                    height: h * 0.047,
                    width: w * 0.85,
                    controller: viewModel.passwordController,
                    obscureText: true,
                    labelText: 'Enter Password',
                    icon: CupertinoIcons.eye,
                  ),
                  SizedBox(height: h * 0.07),
                      CustomElevatedButton(
                          buttonStyle: ButtonStyle(
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                              backgroundColor:
                              MaterialStatePropertyAll(Color(0xffF6D5CA))),
                          width: 232,
                          height: 43,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          text: "SIGN UP",
                          margin: EdgeInsets.symmetric(horizontal: 32),
                          onPressed: () {
                            viewModel.signUp(context);
                          }),
                      SizedBox(height: h * .26),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don’t have an account ? ",
                                style: TextStyle()),
                            InkWell(
                                onTap: () {
                                  viewModel.onTapTxtSignIn(context);
                                },
                                child: const Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ))
                          ]),
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
