import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

import '../core/api_patient.dart';
import '../model/availability_model.dart';
import '../model/patient_booking_model.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class BookingSlotScreen extends StatefulWidget {
  const BookingSlotScreen({Key? key}) : super(key: key);

  @override
  State<BookingSlotScreen> createState() => _BookingSlotScreenState();
}

class _BookingSlotScreenState extends State<BookingSlotScreen> {
  final ApiClient _apiClient = ApiClient();
  // int? id = -1;
  List<AvailabilityModel> _availDoctors = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<AvailabilityModel> availDoctors = await _apiClient
        .fetchAvailDoctors(); // load the availabilities on Widget init
    setState(() => _availDoctors = availDoctors);
  }

  void addBooking(
    int i,
  ) async {
    PatientBookingModel booking = PatientBookingModel(
        doctorUsername: _availDoctors[i].doctorUsername.toString(),
        patientUsername: currentLoggedInUser["username"].toString(),
        doctorName: _apiClient
            .getDoctorName(_availDoctors[i].doctorUsername.toString())
            .toString(),
        patientName: _apiClient
            .getUserName(currentLoggedInUser["username"].toString())
            .toString(),
        dateTime: _availDoctors[i].availability.toString());
    dynamic res = await _apiClient.addBooking(booking);
    if (res == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Booking Success'),
                content: const Text('Your booking has been added'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/patient/appointments'),
                    child: const Text('OK'),
                  ),
                ]);
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Booking Failure'),
                content: const Text('Cannot add this booking'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: ListView.separated(
        itemCount: _availDoctors.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            onTap: () => {addBooking(i)},
            child: Column(
              children: [
                Text(
                  "Doctor: ${_availDoctors[i].doctorUsername} ",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Available at: ${_availDoctors[i].availability}",
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
