import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        centerTitle: true,
      ),
      body: _myListView(context),
    );
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
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
