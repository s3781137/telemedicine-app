import 'dart:convert';

List<DoctorModel> doctorModelFromJson(String responseBody) =>
    List<DoctorModel>.from(
        json.decode(responseBody).map((x) => DoctorModel.fromJson(x)));

String doctorModelToJson(List<DoctorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorModel {
  DoctorModel({
    this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  int? id;
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  String? email;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}
