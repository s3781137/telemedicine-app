import 'package:flutter/material.dart';
import 'signIn.dart';
import 'welcome.dart';

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: SignInApp(),
    // Routes defined here
    routes: {"/welcome": (context) => WelcomeScreen()},
  ));
}
