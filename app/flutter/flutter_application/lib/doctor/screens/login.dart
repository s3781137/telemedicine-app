import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/api_doctor.dart';
import 'doctor.dart';

class DoctorLogin extends StatefulWidget {
  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiDoctor _apiDoctor = ApiDoctor();

  // login function
  // will set the currentlogged-in user
  Future<void> logIn() async {
    var username = usernameController.text;
    var password = passwordController.text;
    var jwt = await _apiDoctor.logIn(username, password);
    if (jwt != null) {
      const FlutterSecureStorage().write(key: "jwt", value: jwt);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Doctor.fromBase64(jwt)));
      currentLoggedInUser.update(
          "username", (value) => usernameController.text);
      currentLoggedInUser.update("userType", (value) => "doctor");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Login Failure'),
                content: const Text('Cannot log in as doctor'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ND TELEMEDICINE'),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: const Icon(Icons.home),
                )),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Doctor Login',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Sign in'),
                    onPressed: () {
                      logIn();
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
              ],
            )));
  }
}
