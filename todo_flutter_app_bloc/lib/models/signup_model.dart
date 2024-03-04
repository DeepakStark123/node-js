// final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  bool? status;
  String? error;
  String? success;

  SignUpModel({
    this.status,
    this.error,
    this.success,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        error: json["error"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "success": success,
      };
}
