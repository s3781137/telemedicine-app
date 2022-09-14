import 'package:flutter/material.dart';
import 'welcome.dart';

var passwords = {"test": "Password123", "oli": "helloWorld!"};

class SignUpApp extends StatelessWidget {
  const SignUpApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
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
              patientSignUpButton(),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              doctorSignUpButton(),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget patientSignUpButton() {
    return ElevatedButton(onPressed: () {}, child: Text('I am patient'));
  }

  Widget doctorSignUpButton() {
    return ElevatedButton(onPressed: () {}, child: Text('I am doctor'));
  }
}
