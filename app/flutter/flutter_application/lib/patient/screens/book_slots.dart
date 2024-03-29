import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

import '../core/api_patient.dart';
import '../model/availability_model.dart';
import '../model/patient_booking_model.dart';
import '../widgets/appbar.dart';

class BookingSlotScreen extends StatefulWidget {
  const BookingSlotScreen({Key? key}) : super(key: key);

  @override
  State<BookingSlotScreen> createState() => _BookingSlotScreenState();
}

class _BookingSlotScreenState extends State<BookingSlotScreen> {
  final ApiClient _apiClient = ApiClient();
  List<AvailabilityModel> _availDoctors = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  // load the availabilities on Widget init
  void _load() async {
    List<AvailabilityModel> availDoctors = await _apiClient.fetchAvailDoctors();
    setState(() => _availDoctors = availDoctors);
  }

  void addBooking(int i) async {
    // Create booking object
    PatientBookingModel booking = PatientBookingModel(
        doctorUsername: _availDoctors[i].doctorUsername.toString(),
        patientUsername: currentLoggedInUser["username"].toString(),
        doctorName: await _apiClient
            .getDoctorName(_availDoctors[i].doctorUsername.toString()),
        patientName: await _apiClient
            .getUserName(currentLoggedInUser["username"].toString()),
        dateTime: _availDoctors[i].availability.toString());
    // Get response status code
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
