import 'dart:convert';

import 'package:flutter_application/patient/model/petient_health_model.dart';
import 'package:http/http.dart';

import '../model/patient_model.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  // Method for login postMapping
  Future<dynamic> login(String username, password) async {
    try {
      Response response = await http.post(
          Uri.parse('http://localhost:8080/patient/login'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return response.body.toString();
      }
    } catch (e) {}
  }

  // Method for patient registration
  Future<dynamic> register(
      String username,
      String password,
      String confirmPassword,
      String firstName,
      String lastName,
      String email) async {
    try {
      Response response = await http.post(
          Uri.parse('http://localhost:8080/patient/registerPatient'),
          body: {
            'username': username,
            'password': password,
            'confirmPassword': confirmPassword,
            'firstName': firstName,
            'lastName': lastName,
            'email': email
          });
      print("username " + username);

      if (response.statusCode == 200) {
        return response.body.toString();
      }
    } catch (e) {
      throw Exception('Failed to sign up');
    }
  }

  // Return an instance of PatientModel
  Future<PatientModel> getUser(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8080/patient/getBy/$username'));
    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode((response.body)));
    } else {
      throw Exception('Failed to load userdata');
    }
  }

  // Get ID of User by username
  Future<int?> getUserId(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8080/patient/getBy/$username'));
    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode((response.body))).id;
    } else {
      throw Exception('Failed to load userdata');
    }
  }

  // Returns a list of users
  Future<List<PatientModel>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/patient/list'));
    if (response.statusCode == 200) {
      return patientModelFromJson(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<dynamic> updateHealthInfo(PatientHealthModel healthInfo) async {
    try {
      Response response = await http.put(
        Uri.parse('http://localhost:8080/patient/updateHealthInfo'),
        body: jsonEncode(healthInfo),
        headers: <String, String>{"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return response.body.toString();
      }
    } catch (e) {}
  }
}
