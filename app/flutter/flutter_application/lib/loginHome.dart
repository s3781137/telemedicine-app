import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  const LoginHome();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginHomePage(),
      },
    );
  }
}

class LoginHomePage extends StatelessWidget {
  const LoginHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TD TELEMEDICINE'),
        centerTitle: true,
      ),
      body: Center(child: Text('login home page')),
    );
  }
}
