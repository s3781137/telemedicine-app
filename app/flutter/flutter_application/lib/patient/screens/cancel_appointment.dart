import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/model/patient_booking_model.dart';

import '../core/api_patient.dart';
import '../widgets/appbar.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key}) : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  final ApiClient _apiClient = ApiClient();
  List<PatientBookingModel> _bookings = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<PatientBookingModel> bookings = await _apiClient.fetchBookings(
        currentLoggedInUser["username"]
            .toString()); // load the bookings on Widget init

    setState(() => _bookings = bookings);
  }

  void cancelBooking(int i) async {
    dynamic res = await _apiClient.cancelBooking(_bookings[i].id ?? 0);
    if (res == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Cancel Success'),
                content: const Text('Your booking has been cancelled'),
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
                title: const Text('Cancel Failure'),
                content: const Text('Cannot cancel this booking'),
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
        itemCount: _bookings.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            onTap: () => {cancelBooking(i)},
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
