import 'package:cribbies/views/SignIn/login.dart';
import 'package:cribbies/views/SignUp/SignUp_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.formKey,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(children: [
                SizedBox(height: h * .13),
                const SizedBox(
                    height: 110,
                    child:
                        Image(image: AssetImage('assets/cribbies_logo.png'))),
                const Spacer(flex: 18),
                Padding(
                  padding: EdgeInsets.only(right: w * .66),
                  child: const Text("User Name",
                      style: TextStyle(fontSize: 12.98)),
                ),
                const SizedBox(height: 6),
                CustomTextFormField(
                  controller: viewModel.emailController,
                  labelText: '',
                  icon: null,
                  height: h * 0.047,
                  width: w * 0.85,
                ),
                SizedBox(height: h * 0.03),
                Padding(
                  padding: EdgeInsets.only(right: w * .66),
                  child: const Text("Email", style: TextStyle(fontSize: 12.98)),
                ),
                CustomTextFormField(
                  controller: viewModel.emailController,
                  labelText: '',
                  icon: null,
                  height: h * 0.047,
                  width: w * 0.85,
                ),
                SizedBox(height: h * 0.03),
                Padding(
                  padding: EdgeInsets.only(right: w * .66),
                  child:
                      const Text("Password", style: TextStyle(fontSize: 12.98)),
                ),
                const SizedBox(height: 6),
                CustomTextFormField(
                  height: h * 0.047,
                  width: w * 0.85,
                  controller: viewModel.passwordController,
                  obscureText: true,
                  labelText: '',
                  icon: CupertinoIcons.eye,
                ),
                SizedBox(height: h * 0.03),
                SizedBox(height: 51),
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
                        color: Color(0xffF6D5CA)),
                    text: "SIGN UP",
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    onPressed: () {
                      viewModel.signUp(context);
                    }),
                Spacer(flex: 61),
                Padding(
                    padding: EdgeInsets.only(
                      bottom: h * .04,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account ? ", style: TextStyle()),
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
                        ]))
              ])),
        );
      },
      viewModelBuilder: () {
        return SignUpViewModel();
      },
    );
  }
}
