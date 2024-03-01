import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:todo_flutter_app/views/home_screen.dart';
import 'package:todo_flutter_app/utils/apis.dart';
import 'package:todo_flutter_app/utils/utility.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isNotValidated = false.obs;
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var body = {
        "email": emailController.text,
        "password": passwordController.text
      };
      debugPrint("reqbody=>$body \n url=>$loginApi");
      var response = await http.post(
        Uri.parse(loginApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      debugPrint("login-api-statuscode===> ${response.statusCode}");
      debugPrint("login-api-res===> ${response.body}");
      Map<String, dynamic> jsonResponse = jsonDecode(response.body.toString());
      if (response.statusCode == 200 && jsonResponse['status'] == true) {
        debugPrint("login success");
        Utility.customSnackbar('User Register Successfully', true);
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Get.off(() => HomeScreen(token: myToken));
      } else {
        Utility.customSnackbar('${jsonResponse['error']}', false);
        debugPrint("${jsonResponse['error']}");
      }
    } else {
      isNotValidated.value = true;
    }
  }
}
