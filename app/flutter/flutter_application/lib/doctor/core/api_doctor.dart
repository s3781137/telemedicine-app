import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiDoctor {
  Future<String?> logIn(String username, String password) async {
    var res = await http.post(Uri.parse("http://localhost:8081/doctor/login"),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }
}
