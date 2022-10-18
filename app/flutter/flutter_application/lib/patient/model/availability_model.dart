import 'dart:convert';

List<AvailabilityModel> availabilityModelFromJson(String responseBody) =>
    List<AvailabilityModel>.from(
        json.decode(responseBody).map((x) => AvailabilityModel.fromJson(x)));

String availabilityModelToJson(List<AvailabilityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvailabilityModel {
  AvailabilityModel(
      {required this.id,
      required this.doctorUsername,
      required this.availability});

  int? id;
  String? doctorUsername;
  String? availability;

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityModel(
        id: json["id"],
        doctorUsername: json["doctorUsername"],
        availability: json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorUsername": doctorUsername,
        "availability": availability,
      };
}
