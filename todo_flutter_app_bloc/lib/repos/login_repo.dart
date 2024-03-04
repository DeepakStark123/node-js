import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_app/models/login_model.dart';
import 'package:node_app/utils/app_urls.dart';
import 'package:node_app/utils/my_preferences.dart';
import 'package:node_app/utils/utility.dart';

class LoginRepo {
  static Future<LoginModel?> login(
      String email, String passwrod, BuildContext context) async {
    try {
      var reqBody = {'email': email, 'password': passwrod};
      debugPrint("Login-Req-Body = $reqBody");
      var res = await http.post(
        Uri.parse(AppUrls.loginApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      debugPrint("Login-StatusCode= ${res.statusCode}");
      debugPrint("Login-Body = ${res.body}");
      if (res.statusCode == 200) {
        var loginModel = loginModelFromJson(res.body.toString());
        if (loginModel.status == true) {
          MyPreferences.saveToken(loginModel.token ?? "");
          return loginModel;
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(
              context,
              loginModel.error.toString(),
              isSuccess: false,
            );
          }
          return null;
        }
      } else {
        debugPrint("Login failed with status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      throw Exception("Login-Error:$e");
    }
  }
}
