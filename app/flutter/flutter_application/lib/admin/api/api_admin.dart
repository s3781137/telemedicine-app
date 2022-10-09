import 'dart:convert';

import 'package:flutter_application/admin/model/admin_model.dart';
import 'package:http/http.dart' as http;

class ApiAdmin {
  // Future<String?> logIn(String username, String password) async {
  //   var res = await http.post(Uri.parse("http://localhost:8083/admin/login"),
  //       body: {"username": username, "password": password});
  //   if (res.statusCode == 200) return res.body;
  //   return null;
  // }

  Future<int> signUp(AdminModel admin) async {
    var res = await http.post(
      Uri.parse("http://localhost:8083/admin/createAdmin"),
      body: jsonEncode(admin),
      headers: <String, String>{"Content-Type": "application/json"},
    );
    return res.statusCode;
  }
}
