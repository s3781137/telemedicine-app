import 'dart:convert';

List<PatientMedicineModel> patientMedicineModelFromJson(String responseBody) =>
    List<PatientMedicineModel>.from(
        json.decode(responseBody).map((x) => PatientMedicineModel.fromJson(x)));

String patientMedicineModelToJson(List<PatientMedicineModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientMedicineModel {
  PatientMedicineModel(
      {this.id,
      required this.doctorUsername,
      required this.patientUsername,
      required this.medicine});

  int? id;
  String doctorUsername;
  String patientUsername;
  String medicine;

  factory PatientMedicineModel.fromJson(Map<String, dynamic> json) =>
      PatientMedicineModel(
        id: json["id"],
        doctorUsername: json["doctorUsername"],
        patientUsername: json["patientUsername"],
        medicine: json["medicine"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorUsername": doctorUsername,
        "patientUsername": patientUsername,
        "medicine": medicine,
      };
}
