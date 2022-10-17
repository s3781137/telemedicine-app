import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/model/patient_booking_model.dart';

import '../core/api_patient.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class ViewBookingScreen extends StatefulWidget {
  const ViewBookingScreen({Key? key}) : super(key: key);

  @override
  State<ViewBookingScreen> createState() => _ViewBookingScreenState();
}

class _ViewBookingScreenState extends State<ViewBookingScreen> {
  final ApiClient _apiClient = ApiClient();
  int? id = -1;
  List<PatientBookingModel> _bookings = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<PatientBookingModel> bookings = await _apiClient.fetchBookings(
        currentLoggedInUser["username"]
            .toString()); // load the availabilities on Widget init

    setState(() => _bookings = bookings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: ListView.separated(
        itemCount: _bookings.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            // todo on tap
            onTap: () => {},
            child: Column(
              children: [
                Text(
                  "Doctor: ${_bookings[i].doctorUsername} ",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Date and Time: ${_bookings[i].dateTime}",
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
