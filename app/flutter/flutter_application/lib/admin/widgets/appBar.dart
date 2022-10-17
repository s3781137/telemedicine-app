import 'package:flutter/material.dart';
import 'package:flutter_application/patient/core/api_patient.dart';

import '../../main.dart';
import '../screens/admin.dart';

makeAppBar(BuildContext context, String jwt) {
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
                        .popUntil(ModalRoute.withName("/adminsignin")),
                  },
                  value: 'logout',
                  child: Text('Log out'),
                ),
              ];
            },
          )),
      Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Admin.fromBase64(jwt)));
            },
            child: Icon(Icons.home),
          )),
    ],
  );
}
