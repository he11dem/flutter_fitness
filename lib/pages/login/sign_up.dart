// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_fitness/Const/color_constans.dart';
import 'package:flutter_fitness/Const/common%20widgets/round_button.dart';
import 'package:flutter_fitness/Const/common%20widgets/round_textfiled.dart';
import 'package:flutter_fitness/database/auth/service.dart';
import 'package:flutter_fitness/database/collections/user_collection.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool visibiliti = false;
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController checkController = TextEditingController();
  UsersCollection usersCollection = UsersCollection();
  bool isCheck = false;
  bool vis = false;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hey there,",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text(
                      "Create an Account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.01,
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    RoundTextField(
                      hitText: "First Name",
                      icon: 'assets/img/user_text.png',
                      controller: nameController,
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    RoundTextField(
                      hitText: "Email ",
                      icon: 'assets/img/email.png',
                      controller: emailController,
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                        child: RoundTextField(
                            hitText: "Password",
                            icon: "assets/img/lock.png",
                            controller: passController,
                            obscureText: !visibiliti,
                            rigtIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibiliti = !visibiliti;
                                  });
                                },
                                icon: visibiliti
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)))),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                        child: RoundTextField(
                            hitText: "Re-enter password",
                            icon: "assets/img/lock.png",
                            controller: checkController,
                            obscureText: !vis,
                            rigtIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    vis = !vis;
                                  });
                                },
                                icon: vis
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)))),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RoundButton(
                        title: "Register",
                        onPressed: () async {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passController.text.isEmpty ||
                              checkController.text.isEmpty) {
                            Toast.show("Warning! Fill in the fields!");
                          } else {
                            if (checkController.text == passController.text) {
                              var user = await authService.singUp(
                                  emailController.text, passController.text);
                              if (user != null) {
                                await usersCollection.addUsersCollection(
                                    user.id!,
                                    nameController.text,
                                    emailController.text,
                                    passController.text,
                                    checkController.text);
                                Navigator.popAndPushNamed(context, '/complete');
                              } else {
                                Toast.show(
                                    'Check the correctness of the data!');
                              }
                            } else {
                              Toast.show('Passwords dont match');
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.02,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/sign_in');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
