import 'package:todo_flutter_app/utils/utility.dart';
import 'package:todo_flutter_app/utils/apis.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:todo_flutter_app/views/signIn_page.dart';

class RegistrationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isNotValidated = false.obs;

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      debugPrint("regBody=> $regBody");
      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      debugPrint("signup-api-statuscode===> ${response.statusCode}");
      debugPrint("signup-api-res===> ${response.body}");
      Map<String, dynamic> jsonResponse = jsonDecode(response.body.toString());
      debugPrint(jsonResponse['status'].toString());
      if (response.statusCode == 200 && jsonResponse['status'] == true) {
        debugPrint("registration success");
        Utility.customSnackbar('User LogedIn Successfully', true);
        Get.off(const SignInPage());
      } else {
        Utility.customSnackbar('${jsonResponse['error']}', false);
        debugPrint("${jsonResponse['error']}");
      }
    } else {
      isNotValidated.value = true;
    }
  }
}
