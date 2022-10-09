import 'dart:convert';

List<AdminModel> adminModelFromJson(String responseBody) =>
    List<AdminModel>.from(
        json.decode(responseBody).map((x) => AdminModel.fromJson(x)));

String adminModelToJson(List<AdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminModel {
  AdminModel(
      {this.id,
      required this.username,
      required this.password,
      required this.confirmPassword});

  int? id;
  String? username;
  String? password;
  String? confirmPassword;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
