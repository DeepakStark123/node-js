import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utility {
  static customSnackbar(String msg, bool apiStatus) {
    Get.snackbar(
      apiStatus ? "Success" : "Error",
      msg,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      backgroundColor: apiStatus ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }
}
