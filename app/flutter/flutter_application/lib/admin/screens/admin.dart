import 'package:flutter/material.dart';
import 'package:flutter_application/patient/screens/add_health_info.dart';

class Admin extends StatelessWidget {
  Admin({Key? key}) : super(key: key);

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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Admin()));
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
            onTap: () => Navigator.of(context).pushNamed('/admin/profile'),
          ),
        ],
      ),
    );
  }
}
