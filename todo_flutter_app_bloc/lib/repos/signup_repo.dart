import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_app/models/signup_model.dart';
import 'package:node_app/utils/app_urls.dart';
import 'package:node_app/utils/utility.dart';

class SignUpRepo {
  static Future<SignUpModel?> signUp(
      String email, String passwrod, BuildContext context) async {
    try {
      var reqBody = {'email': email, 'password': passwrod};
      debugPrint("SignUp-Req-Body = $reqBody");
      var res = await http.post(
        Uri.parse(AppUrls.registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      debugPrint("SignUp-StatusCode= ${res.statusCode}");
      debugPrint("SignUp-Body = ${res.body}");
      if (res.statusCode == 200) {
        var signupModel = signUpModelFromJson(res.body.toString());
        if (signupModel.status == true) {
          return signupModel;
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(
              context,
              signupModel.error.toString(),
              isSuccess: false,
            );
          }
          return null;
        }
      } else {
        debugPrint("SignUp failed with status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      throw Exception("SignUp-Error:$e");
    }
  }
}
