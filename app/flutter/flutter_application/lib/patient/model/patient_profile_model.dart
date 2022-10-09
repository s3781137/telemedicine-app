import 'dart:convert';

List<PatientProfileModel> patientProfileModelFromJson(String responseBody) =>
    List<PatientProfileModel>.from(
        json.decode(responseBody).map((x) => PatientProfileModel.fromJson(x)));

String patientProfileModelToJson(List<PatientProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientProfileModel {
  PatientProfileModel(
      {required this.id,
      required this.gender,
      required this.weight,
      required this.height,
      required this.contactNo,
      required this.contactName});

  int? id;
  String? gender;
  double? weight;
  double? height;
  String? contactNo;
  String? contactName;

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) =>
      PatientProfileModel(
        id: json["id"],
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
        contactNo: json["contactNo"],
        contactName: json["contactName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "weight": weight,
        "height": height,
        "contactNo": contactNo,
        "contactName": contactName,
      };
}
