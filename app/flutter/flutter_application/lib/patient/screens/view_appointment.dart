import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/model/patient_booking_model.dart';

import '../core/api_patient.dart';
import '../patient.dart';

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
    // todo: debug msg
    print(
        "_load async: current user: ${currentLoggedInUser["username"].toString()}");
    List<PatientBookingModel> bookings = await _apiClient.fetchBookings(
        currentLoggedInUser["username"]
            .toString()); // load the availabilities on Widget init

    setState(() => _bookings = bookings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ND TELEMEDICINE'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: PopupMenuButton(
                child: Icon(Icons.account_circle),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text('Log out'),
                    ),
                    const PopupMenuItem(
                      value: 'changePW',
                      child: Text('Change Password'),
                    ),
                    const PopupMenuItem(
                      value: 'rmAccount',
                      child: Text('Delete account'),
                    ),
                  ];
                },
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Patient()));
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: _bookings.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            // todo on tap
            onTap: () => {},
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
