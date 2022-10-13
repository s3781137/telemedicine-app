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
      required this.email,
      required this.gender,
      required this.height,
      required this.weight,
      required this.contactNo,
      required this.contactName});

  int? id;
  String? username;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  double? weight;
  double? height;
  String? contactNo;
  String? contactName;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
        contactNo: json["contactNo"],
        contactName: json["contactName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "weight": weight,
        "height": height,
        "contactNo": contactNo,
        "contactName": contactName,
      };
}
