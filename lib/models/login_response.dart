// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/models/user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.message,
    required this.token,
  });

  bool ok;
  User message;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      ok: json["ok"],
      message: json["message"] != null
          ? User.fromJson(json["message"])
          : User.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ok": ok,
      "message": message.toJson(),
      "token": token,
    };
  }
}
