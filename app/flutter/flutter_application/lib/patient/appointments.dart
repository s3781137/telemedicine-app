import 'package:flutter/material.dart';
import 'package:flutter_application/patient/widgets/appbar.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen();
  // Page for patient making appoinments
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: _myListView(context),
    );
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    // Gives a listview of options
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          title: Text('Book An Appointment'),
          onTap: () =>
              Navigator.of(context).pushNamed('/patient/appointments/book'),
        ),
        ListTile(
          title: Text('Cancel An Appointment'),
          onTap: () =>
              Navigator.of(context).pushNamed('/patent/appointments/cancel'),
        ),
        ListTile(
          title: Text('View Current Bookings'),
          onTap: () =>
              Navigator.of(context).pushNamed('/patient/appointments/view'),
        ),
      ],
    ).toList(),
  );
}
