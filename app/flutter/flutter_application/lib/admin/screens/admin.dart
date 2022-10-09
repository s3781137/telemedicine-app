import 'dart:convert';

import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  Admin(this.jwt, this.payload);

  factory Admin.fromBase64(String jwt) => Admin(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ND TELEMEDICINE'),
        actions: <Widget>[
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
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            // todo: icon
            // leading: CircleAvatar(
            //   backgroundImage: AssetImage('assets/ManageProfile.png'),
            // ),
            title: Text('Create Doctor Profile'),
            onTap: () => Navigator.of(context).pushNamed('/admincreatedoctor'),
          ),
        ],
      ),
    );
  }
}
