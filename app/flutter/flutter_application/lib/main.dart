import 'package:flutter/material.dart';
import 'package:flutter_application/loginHome.dart';
import 'welcome.dart';

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: LoginHome(),
    // Routes defined here
    routes: {"/welcome": (context) => WelcomeScreen()},
  ));
}
