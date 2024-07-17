import 'dart:convert';

import 'package:http/http.dart' as http;

import 'globals.dart';

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password,String phone,int cinsiyet) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "phone_number": phone,
      "cinsiyet": cinsiyet,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}register');
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}login');
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }
}
