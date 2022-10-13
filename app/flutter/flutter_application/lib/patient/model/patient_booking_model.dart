import 'dart:convert';

List<PatientBookingModel> patientBookingModelFromJson(String responseBody) =>
    List<PatientBookingModel>.from(
        json.decode(responseBody).map((x) => PatientBookingModel.fromJson(x)));

String patientBookingModelToJson(List<PatientBookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientBookingModel {
  PatientBookingModel(
      {required this.id,
      required this.doctorUsername,
      required this.patientUsername,
      required this.doctorName,
      required this.patientName,
      required this.dateTime});

  int? id;
  String doctorUsername;
  String patientUsername;
  String doctorName;
  String patientName;
  String dateTime;

  factory PatientBookingModel.fromJson(Map<String, dynamic> json) =>
      PatientBookingModel(
        id: json["id"],
        doctorUsername: json["doctorUsername"],
        patientUsername: json["patientUsername"],
        doctorName: json["doctorName"],
        patientName: json["patientName"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorUsername": doctorUsername,
        "patientUsername": patientUsername,
        "doctorName": doctorName,
        "patientName": patientName,
        "dateTime": dateTime,
      };
}
