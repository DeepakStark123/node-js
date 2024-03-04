import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  String? success;
  String? error;
  String? token;

  LoginModel({
    this.status,
    this.success,
    this.error,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "error": error,
        "token": token,
      };
}
