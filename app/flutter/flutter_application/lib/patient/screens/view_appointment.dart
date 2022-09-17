import 'package:flutter/material.dart';

class ViewAppointmentScreen extends StatelessWidget {
  const ViewAppointmentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Current Bookings'),
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
          title: Text('Dr Jeon Junkook, 09:30 26/08/2022, Manor Lakes'),
        ),
        ListTile(
          title: Text('Dr Doja Cat, 10:30 26/08/2022, Footscray'),
        ),
        ListTile(
          title: Text('Dr Justin Bieber, 11:30 16/01/2023, Melbourne Central'),
        ),
        ListTile(
          title: Text('Dr Kanye West, 00:30 06/07/2023,Chadstone'),
        )
      ],
    ).toList(),
  );
}
