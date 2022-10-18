import 'dart:convert';

import 'package:flutter_application/admin/model/doctor_model.dart';
import 'package:flutter_application/patient/model/availability_model.dart';
import 'package:flutter_application/patient/model/patient_profile_model.dart';
import 'package:flutter_application/patient/model/patient_symptoms_model.dart';
import 'package:flutter_application/patient/model/petient_health_model.dart';
import 'package:http/http.dart';

import '../model/patient_booking_model.dart';
import '../model/patient_medicine_model.dart';
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
  Future<dynamic> register(PatientModel patient) async {
    try {
      Response response = await http.post(
          Uri.parse('http://localhost:8080/patient/registerPatient'),
          body: jsonEncode(patient),
          headers: <String, String>{"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {
      throw Exception('Failed to sign up');
    }
  }

  // Method for patient deletion
  Future<dynamic> deleteUser(String username) async {
    try {
      Response response = await http.delete(
          Uri.parse('http://localhost:8080/patient/detele/$username'),
          headers: <String, String>{"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {
      throw Exception('Failed to delete patient');
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

  // Get Name of User by username
  Future<String?> getUserName(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8080/patient/getBy/$username'));
    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode((response.body))).firstName;
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
        Uri.parse('http://localhost:8084/healthinfo/updateHealthInfo'),
        body: jsonEncode(healthInfo),
        headers: <String, String>{"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {}
  }

  Future<dynamic> updateProfile(PatientProfileModel profile) async {
    try {
      Response response = await http.put(
        Uri.parse('http://localhost:8080/patient/update'),
        body: jsonEncode(profile),
        headers: <String, String>{"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {}
  }

  Future<dynamic> addBooking(PatientBookingModel booking) async {
    try {
      Response response = await http.post(
        Uri.parse('http://localhost:8085/booking/addBooking'),
        body: jsonEncode(booking),
        headers: <String, String>{"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {}
  }

  // return a list of available doctors
  Future<List<AvailabilityModel>> fetchAvailDoctors() async {
    final response = await http
        .get(Uri.parse('http://localhost:8085/booking/getAvailability'));
    if (response.statusCode == 200) {
      return availabilityModelFromJson(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Return an instance of DoctorModel
  Future<DoctorModel> getDoctor(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8081/doctor/getBy/$username'));
    if (response.statusCode == 200) {
      return DoctorModel.fromJson(jsonDecode((response.body)));
    } else {
      throw Exception('Failed to load userdata');
    }
  }

  // Return doctor name by username
  Future<String?> getDoctorName(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8081/doctor/getBy/$username'));
    if (response.statusCode == 200) {
      return DoctorModel.fromJson(jsonDecode((response.body))).firstName;
    } else {
      throw Exception('Failed to load userdata');
    }
  }

  // return a list of bookings
  Future<List<PatientBookingModel>> fetchBookings(String username) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8085/booking/viewPatientBookings?patientUsername=$username'));
    if (response.statusCode == 200) {
      return patientBookingModelFromJson(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // return a list of medicines of current patient
  Future<List<PatientMedicineModel>> fetchMedicines(String username) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8082/prescription/view?patientUsername=$username'));
    if (response.statusCode == 200) {
      return patientMedicineModelFromJson(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Method for cancelling booking
  Future<dynamic> cancelBooking(int bookingId) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8085/booking/cancelBooking?bookingId=$bookingId'));
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // method for updating symptoms
  Future<dynamic> updateSymptoms(
      String username, PatientSymptomsModel symptoms) async {
    try {
      Response response = await http.put(
        Uri.parse('http://localhost:8089/symptoms/updateSymptoms/$username'),
        body: jsonEncode(symptoms),
        headers: <String, String>{"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {}
  }

  // Return an instance of PatientSymptomsModel
  Future<PatientSymptomsModel> getSymptoms(String username) async {
    Response response = await http
        .get(Uri.parse('http://localhost:8089/symptoms/getSymptoms/$username'));
    if (response.statusCode == 200) {
      return PatientSymptomsModel.fromJson(jsonDecode((response.body)));
    } else {
      throw Exception('Failed to load userdata');
    }
  }
}
