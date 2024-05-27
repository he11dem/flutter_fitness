// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_fitness/Const/color_constans.dart';
import 'package:flutter_fitness/Const/common%20widgets/round_button.dart';
import 'package:flutter_fitness/Const/common%20widgets/round_textfiled.dart';
import 'package:flutter_fitness/database/auth/service.dart';
import 'package:toast/toast.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool visibility = false;
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: media.height * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hey there,",
                    style: TextStyle(color: TColor.gray, fontSize: 16),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  RoundTextField(
                    hitText: "Email",
                    icon: "assets/img/email.png",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  SizedBox(
                      child: RoundTextField(
                          hitText: "Password",
                          icon: "assets/img/lock.png",
                          controller: passController,
                          obscureText: !visibility,
                          rigtIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: visibility
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)))),
                  SizedBox(
                    height: media.width * 0.01,
                  ),
                  SizedBox(
                    height: media.width * 0.65,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RoundButton(
                      title: "Login",
                      onPressed: () async {
                        if (emailController.text.isEmpty ||
                            passController.text.isEmpty) {
                          Toast.show("Warning! Fill in the fields!");
                        } else {
                          var user = await authService.singIn(
                              emailController.text, passController.text);
                          if (user == null) {
                            Toast.show('Email/Password is not correct!');
                          } else {
                            Navigator.popAndPushNamed(context, "/");
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  SizedBox(
                    height: media.width * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/sign_up');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "No account?",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: media.width * 0.01,
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
