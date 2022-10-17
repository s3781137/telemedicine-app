import 'dart:convert';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../widgets/appBar.dart';

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
      appBar: makeAppBar(context, jwt),
      body: ListView(
        children: <Widget>[
          ListTile(
            // todo: icon
            // leading: CircleAvatar(
            //   backgroundImage: AssetImage('assets/ManageProfile.png'),
            // ),
            title: Text('Create Doctor'),
            onTap: () => Navigator.of(context).pushNamed('/admincreatedoctor'),
          ),
          ListTile(
            // todo: icon
            // leading: CircleAvatar(
            //   backgroundImage: AssetImage('assets/ManageProfile.png'),
            // ),
            title: Text('Update Doctor'),
            onTap: () => Navigator.of(context).pushNamed('/admincreatedoctor'),
          ),
          ListTile(
            // todo: icon
            // leading: CircleAvatar(
            //   backgroundImage: AssetImage('assets/ManageProfile.png'),
            // ),
            title: Text('Delete Doctor'),
            onTap: () => Navigator.of(context).pushNamed('/admincreatedoctor'),
          ),
        ],
      ),
    );
  }
}
