import 'dart:convert';

import 'package:flutter_application/patient/model/petient_health_model.dart';
import 'package:flutter_application/patient/screens/add_health_info.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiDoctor {
  Future<String?> logIn(String username, String password) async {
    var res = await http.post(Uri.parse("http://localhost:8081/doctor/login"),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<dynamic> addAvail(String username, String avail) async {
    var res = await http.post(
        Uri.parse("http://localhost:8085/booking/addAvailability"),
        body: {"doctorUsername": username, "availability": avail});
    if (res.statusCode == 200) return res.statusCode;
    return null;
  }

  // Return an instance of health info model
  Future<PatientHealthModel> getHealthInfo(int? id) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8084/healthinfo/getHealthInfo/$id'));
    if (response.statusCode == 200) {
      return PatientHealthModel.fromJson(jsonDecode((response.body)));
    } else {
      throw Exception('Failed to load userdata');
    }
  }
}
