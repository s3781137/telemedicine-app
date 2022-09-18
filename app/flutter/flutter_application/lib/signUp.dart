import 'package:flutter/material.dart';
import 'package:flutter_application/doctor/doctorSignUp.dart';
import 'doctor/welcome.dart';

var passwords = {"test": "Password123", "oli": "helloWorld!"};

class SignUpApp extends StatelessWidget {
  const SignUpApp();

  @override
  Widget build(BuildContext context) {
    return const SignUpScreen();
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();
  // page for choosing sign up as doctor or patient
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 600,
          child: Card(
              child: Column(
            children: [
              patientSignUpButton(context),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget patientSignUpButton(BuildContext context) {
    // todo: patient registration page
    return ElevatedButton(onPressed: () {}, child: Text('I am patient'));
  }
}
