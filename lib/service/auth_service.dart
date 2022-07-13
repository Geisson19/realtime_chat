import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/models/models.dart';
import 'package:realtime_chat/models/signup_response.dart';

class AuthService with ChangeNotifier {
  late User user;

  static String errorMessage = "Por favor, llena todos los campos";

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final _secureStorage = const FlutterSecureStorage();

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// It returns a Future<String> that will eventually contain the token.
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token ?? '';
  }

  /// It deletes the token from the device's storage
  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  /// It takes an email and password, sends them to the server, and returns true if the server responds
  /// with a 200 status code
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password of the user.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> login(String email, String password) async {
    isLoading = true;

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final uri = Uri.http(Enviroment.apiUrl, '/api/auth/login');

    final response = await http.post(uri, body: jsonEncode(authData), headers: {
      'Content-Type': 'application/json',
    });

    isLoading = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.message;

      await _saveToken(loginResponse.token);

      return true;
    }

    return false;
  }

  /// A function that takes in three parameters, name, email, and password. It returns a Future<bool>
  /// which is a boolean value.
  ///
  /// Args:
  ///   name (String): The name of the user.
  ///   email (String): The email of the user.
  ///   password (String): The password of the user.
  Future<bool> signUp(String name, String email, String password) async {
    isLoading = true;

    final Map<String, dynamic> authData = {
      'name': name,
      'email': email,
      'password': password,
    };

    final uri = Uri.http(Enviroment.apiUrl, '/api/auth/signup');

    final response = await http.post(uri, body: jsonEncode(authData), headers: {
      'Content-Type': 'application/json',
    });

    isLoading = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.message;

      await _saveToken(loginResponse.token);

      return true;
    }

    final SignUpResponse signUpResponse = signUpResponseFromJson(response.body);
    errorMessage = signUpResponse.msg == "" ? errorMessage : signUpResponse.msg;
    return false;
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();

    final response = await http.get(
      Uri.http(Enviroment.apiUrl, '/api/auth/'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.message;
      await _saveToken(loginResponse.token);
      return true;
    }

    logout();
    return false;
  }

  /// _saveToken() is an asynchronous function that takes a string as an argument and returns a future
  ///
  /// Args:
  ///   token (String): The token you want to save.
  ///
  /// Returns:
  ///   The token is being returned.
  Future _saveToken(String token) async {
    return await _secureStorage.write(key: 'token', value: token);
  }

  /// It deletes the token from the secure storage
  Future logout() async {
    await _secureStorage.delete(key: 'token');
  }
}
