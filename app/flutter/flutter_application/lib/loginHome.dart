import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  const LoginHome();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginHome(),
      },
    );
  }
}
