import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/model/patient_booking_model.dart';

import '../core/api_patient.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key}) : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  final ApiClient _apiClient = ApiClient();
  int? id = -1;
  List<PatientBookingModel> _bookings = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    // todo: debug msg
    print(
        "_load async: current user: ${currentLoggedInUser["username"].toString()}");
    List<PatientBookingModel> bookings = await _apiClient.fetchBookings(
        currentLoggedInUser["username"]
            .toString()); // load the availabilities on Widget init

    setState(() => _bookings = bookings);
  }

  void cancelBooking(int i) {
    _apiClient.cancelBooking(_bookings[i].id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: ListView.builder(
        itemCount: _bookings.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            // todo on tap
            onTap: () => {cancelBooking(i)},
            child: Column(
              children: [
                Text("Doctor: ${_bookings[i].doctorUsername} "),
                Text("Date and Time: ${_bookings[i].dateTime}")
              ],
            ),
          );
        },
      ),
    );
  }
}
