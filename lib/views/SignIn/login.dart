import 'package:Potrack/views/SignIn/login_viewmodel.dart';
import 'package:Potrack/widgets/custom_elevated_button.dart';
import 'package:Potrack/widgets/custom_textfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

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
        return SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                    children: [
                  SizedBox(height: h * .12),
                  const SizedBox(
                      height: 110,
                      child: Image(image: AssetImage('assets/Potrack_logo.png'))),
                  const Spacer(flex: 18),
                  Padding(
                    padding: EdgeInsets.only(right: w * .67),
                    child:
                        Text("Username", style: TextStyle(fontSize: 12.98)),
                  ),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    controller: viewModel.userNameController,
                    labelText: '',
                    icon: null,
                    height: h*0.047,
                    width: w*0.85,
                  ),
                  SizedBox(height: h*.03),
                  Padding(
                    padding: EdgeInsets.only(right: w * .67),
                    child: const Text("Password",
                        style: TextStyle(fontSize: 12.98)),
                  ),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    height: h*0.047,
                    width: w*0.85,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    controller: viewModel.passwordController,
                    obscureText: true,
                    labelText: '',
                    icon: CupertinoIcons.eye,
                  ),
                   SizedBox(height: h*.009),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.only(right: w * .06),
                          child: const Text("Forgot Password ?",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        )),
                  ),
                  SizedBox(height: h*.05),
                  CustomElevatedButton(
                      buttonStyle: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffF6D5CA))),
                      width: 232,
                      height: 43,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffF6D5CA)),
                      text: "SIGN IN",
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      onPressed: () {
                        viewModel.onTapLOGIN(context);
                      }),
                  Spacer(flex: 61),
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
                          ]))
                ])));
      },
      viewModelBuilder: () {
        return SignInViewModel();
      },
    );
  }

}
