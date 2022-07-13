// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    required this.ok,
    required this.msg,
    this.token,
  });

  bool ok;
  String msg;
  String? token;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      ok: json["ok"],
      msg: json["msg"] ?? "",
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ok": ok,
      "message": msg,
      "token": token,
    };
  }
}
