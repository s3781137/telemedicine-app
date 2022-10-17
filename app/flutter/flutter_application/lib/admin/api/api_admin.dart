import 'dart:convert';

import 'package:flutter_application/admin/model/admin_model.dart';
import 'package:flutter_application/admin/model/doctor_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiAdmin {
  Future<String?> logIn(String username, String password) async {
    var res = await http.post(Uri.parse("http://localhost:8083/admin/login"),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> signUp(AdminModel admin) async {
    var res = await http.post(
      Uri.parse("http://localhost:8083/admin/createAdmin"),
      body: jsonEncode(admin),
      headers: <String, String>{"Content-Type": "application/json"},
    );
    return res.statusCode;
  }

  Future<int> createDoctor(DoctorModel doctor) async {
    var res = await http.post(
      Uri.parse("http://localhost:8083/admin/createDoctor"),
      body: jsonEncode(doctor),
      headers: <String, String>{"Content-Type": "application/json"},
    );
    return res.statusCode;
  }

  // return a list of doctors
  Future<List<DoctorModel>> fetchDoctors() async {
    final response =
        await http.get(Uri.parse('http://localhost:8083/admin/listDoctors'));
    if (response.statusCode == 200) {
      return doctorModelFromJson(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<dynamic> updateDoctor(DoctorModel doctor) async {
    try {
      Response response = await http.put(
        Uri.parse('http://localhost:8083/admin/updateDoctor/${doctor.id}'),
        body: jsonEncode(doctor),
        headers: <String, String>{"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {}
  }
}
