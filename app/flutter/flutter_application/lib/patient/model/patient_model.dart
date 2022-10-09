import 'dart:convert';

List<PatientModel> patientModelFromJson(String responseBody) =>
    List<PatientModel>.from(
        json.decode(responseBody).map((x) => PatientModel.fromJson(x)));

String patientModelToJson(List<PatientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientModel {
  PatientModel(
      {this.id,
      required this.username,
      required this.password,
      required this.confirmPassword,
      required this.firstName,
      required this.lastName,
      required this.email});

  int? id;
  String? username;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? email;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}
