import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthMethods {
  static String userId = "";
  Future<String> register(
      String username, String email, String password) async {
    username.trim();
    password.trim();
    String output = "Alanlar Boş Bırakılamaz!";
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:9090/api/v1/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'userName': username,
            'password': password,
            'email': email
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("A new user has been registered!");
        output = "Success";
      } else {
        output =
            "Lütfen en az 8 haneli bir şifre giriniz.\nLütfen daha önce oluşturulmamış bir kullanıcı adı ve email adresi deneyiniz.";
      }
    }

    return output;
  }

  Future<String> login(String username, String password) async {
    username.trim();
    password.trim();
    String output = "Alanlar Boş Bırakılamaz!";
    if (username.isNotEmpty && password.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:9090/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'userName': username,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        output = "Success";
        debugPrint("User logged in!");
      } else {
        output = "Kullanıcı Bilgilerinizi Kontrol Ediniz!";
      }
    }
    return output;
  }

  Future<String> getUserId(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:9090/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'userName': username,
          'password': password,
        },
      ),
    );
    return response.body;
  }

  Future<String> logout() async {
    String output = "Başarısız çıkış yapma isteği!";
    final response = await http.post(
      Uri.parse("http://localhost:9090/user/logout"),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      output = "Success";
      debugPrint("User logged out!");
    } else {
      output = "Lütfen tekrar deneyiniz!";
    }
    return output;
  }
}
