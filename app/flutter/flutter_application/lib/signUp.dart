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
      body: const Center(
        child: SizedBox(
          width: 600,
          child: Card(
            child: Text("patient?doctor?"),
          ),
        ),
      ),
    );
  }
}
