import 'dart:convert';

List<PatientSymptomsModel> patientSymptomsModelFromJson(String responseBody) =>
    List<PatientSymptomsModel>.from(
        json.decode(responseBody).map((x) => PatientSymptomsModel.fromJson(x)));

String patientSymptomsModelToJson(List<PatientSymptomsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientSymptomsModel {
  PatientSymptomsModel(
      {this.id,
      required this.painScale,
      required this.bodyTemperature,
      required this.cough,
      required this.runnyNose,
      required this.userName});

  int? id;
  int? painScale;
  double? bodyTemperature;
  String? cough;
  bool? runnyNose;
  String? userName;

  factory PatientSymptomsModel.fromJson(Map<String, dynamic> json) =>
      PatientSymptomsModel(
        id: json["id"],
        painScale: json["painScale"],
        bodyTemperature: json["bodyTemperature"],
        cough: json["cough"],
        runnyNose: json["runnyNose"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "painScale": painScale,
        "bodyTemperature": bodyTemperature,
        "cough": cough,
        "runnyNose": runnyNose,
        "userName": userName,
      };
}
