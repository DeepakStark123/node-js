import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_app/controllers/signup_controller.dart';
import 'package:todo_flutter_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/applogo.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  RegistrationController signUpController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: backgroundLinerColor,
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 0.8],
                tileMode: TileMode.mirror),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonLogo(),
                  const HeightBox(20),
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.make(),
                  const HeightBox(10),
                  Obx(
                    () => TextField(
                      controller: signUpController.emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: const TextStyle(color: Colors.white),
                          errorText: signUpController.isNotValidated.value
                              ? "Enter Proper Info"
                              : null,
                          hintText: "Email",
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                  ),
                  Obx(
                    () => TextField(
                      controller: signUpController.passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              final data = ClipboardData(
                                  text:
                                      signUpController.passwordController.text);
                              Clipboard.setData(data);
                            },
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.password),
                            onPressed: () {
                              String passGen = generatePassword();
                              signUpController.passwordController.text =
                                  passGen;
                              setState(() {});
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: const TextStyle(color: Colors.white),
                          errorText: signUpController.isNotValidated.value
                              ? "Enter Proper Info"
                              : null,
                          hintText: "Password",
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      signUpController.registerUser();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Sign In");
                      Get.back();
                    },
                    child: HStack([
                      "Already Registered?".text.size(16).make(),
                      " Sign In".text.size(16).white.make()
                    ]).centered(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String generatePassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String symbols = '!@#\$%^&*()<>,./';
  String password = '';
  int passLength = 20;

  String seed = upper + lower + numbers + symbols;

  List<String> list = seed.split('').toList();

  Random rand = Random();

  for (int i = 0; i < passLength; i++) {
    int index = rand.nextInt(list.length);
    password += list[index];
  }
  return password;
}
