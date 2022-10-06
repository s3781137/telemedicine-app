import 'dart:convert';

List<PatientHealthModel> patientHealthModelFromJson(String responseBody) =>
    List<PatientHealthModel>.from(
        json.decode(responseBody).map((x) => PatientHealthModel.fromJson(x)));

String patientHealthModelToJson(List<PatientHealthModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientHealthModel {
  PatientHealthModel(
      {required this.id,
      required this.cancer,
      required this.diabetes,
      required this.heartDisease,
      required this.kidneyDisease,
      required this.liverDisease,
      required this.medicalProblems,
      required this.medication,
      required this.medicationDescription,
      required this.pastSurgeries});

  int? id;
  String? cancer;
  String? diabetes;
  String? heartDisease;
  String? kidneyDisease;
  String? liverDisease;
  String? medicalProblems;
  String? medication;
  String? medicationDescription;
  String? pastSurgeries;

  factory PatientHealthModel.fromJson(Map<String, dynamic> json) =>
      PatientHealthModel(
          id: json["id"],
          cancer: json["cancer"],
          diabetes: json["diabetes"],
          heartDisease: json["heartDisease"],
          kidneyDisease: json["kidneyDisease"],
          liverDisease: json["liverDisease"],
          medicalProblems: json["medicalProblems"],
          medication: json["medication"],
          medicationDescription: json["medicationDescription"],
          pastSurgeries: json["pastSurgeries"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cancer": cancer,
        "diabetes": diabetes,
        "heartDisease": heartDisease,
        "kidneyDisease": kidneyDisease,
        "liverDisease": liverDisease,
        "medicalProblems": medicalProblems,
        "medication": medication,
        "medicationDescription": medicationDescription,
        "pastSurgeries": pastSurgeries
      };
}
