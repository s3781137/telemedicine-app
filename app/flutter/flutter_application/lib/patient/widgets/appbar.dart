import 'package:flutter/material.dart';
import 'package:flutter_application/patient/core/api_patient.dart';

import '../../main.dart';
import '../patient.dart';

makeAppBar(BuildContext context) {
  return AppBar(
    title: Text('ND TELEMEDICINE'),
    actions: <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: PopupMenuButton(
            child: Icon(Icons.account_circle),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () => {
                    currentLoggedInUser.update("username", (value) => ""),
                    currentLoggedInUser.update("userType", (value) => ""),
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("/loginhome")),
                  },
                  value: 'logout',
                  child: Text('Log out'),
                ),
                PopupMenuItem(
                  value: 'changePW',
                  child: Text('Change Password'),
                ),
                PopupMenuItem(
                  onTap: () => {
                    ApiClient()
                        .deleteUser(currentLoggedInUser["username"].toString()),
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("/loginhome")),
                  },
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
  );
}
