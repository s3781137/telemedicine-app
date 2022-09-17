import 'package:flutter/material.dart';

class CancelAppointmentScreen extends StatelessWidget {
  const CancelAppointmentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel An Appointment'),
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
          onTap: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text('Are you sure to cancel?'),
                      content: const Text('Confirmation'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Yes'),
                        ),
                      ]);
                });
          }),
        ),
        ListTile(
          title: Text('Dr Doja Cat, 10:30 26/08/2022, Footscray'),
          onTap: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text('Are you sure to cancel?'),
                      content: const Text('Confirmation'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Yes'),
                        ),
                      ]);
                });
          }),
        ),
        ListTile(
          title: Text('Dr Justin Bieber, 11:30 16/01/2023, Melbourne Central'),
          onTap: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text('Are you sure to cancel?'),
                      content: const Text('Confirmation'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Yes'),
                        ),
                      ]);
                });
          }),
        ),
        ListTile(
          title: Text('Dr Kanye West, 00:30 06/07/2023,Chadstone'),
          onTap: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text('Are you sure to cancel?'),
                      content: const Text('Confirmation'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Yes'),
                        ),
                      ]);
                });
          }),
        )
      ],
    ).toList(),
  );
}
