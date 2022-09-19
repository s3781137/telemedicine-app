import 'dart:convert';

import 'package:http/http.dart';

import '../model/patient_model.dart';
import 'package:http/http.dart' as http;

class ApiClient {
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

  // Return an instance of PatientModel
  Future<PatientModel> getUser(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8080/patient/getBy/$username'));
    if (response.statusCode == 200) {
      // todo: remove debug message
      print(PatientModel.fromJson(jsonDecode((response.body))).email);
      return PatientModel.fromJson(jsonDecode((response.body)));
    } else {
      throw Exception('Failed to load userdata');
    }
  }

  Future<List<PatientModel>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/patient/list'));
    if (response.statusCode == 200) {
      print('response body ${response.body}');
      // todo: remove debug msg
      return patientModelFromJson(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
