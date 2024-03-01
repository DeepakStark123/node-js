// ignore_for_file: file_names

import 'package:todo_flutter_app/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_app/utils/colors.dart';
import 'registration.dart';
import '../widgets/applogo.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInController signInController = Get.put(SignInController());

  @override
  void initState() {
    signInController.initSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundLinerColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.8],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonLogo(),
                const SizedBox(height: 20),
                Text(
                  "Sign-In",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.yellow[100],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => TextFormField(
                      controller: signInController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Email",
                        errorStyle: const TextStyle(color: Colors.white),
                        errorText: signInController.isNotValidated.value
                            ? "Enter Proper Info"
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => TextFormField(
                      controller: signInController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Password",
                        errorStyle: const TextStyle(color: Colors.white),
                        errorText: signInController.isNotValidated.value
                            ? "Enter Proper Info"
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    signInController.loginUser();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(const Registration());
                  },
                  child: const Text(
                    "Create a new Account..! Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
