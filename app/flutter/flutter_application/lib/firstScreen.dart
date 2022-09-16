import 'package:flutter/material.dart';
import 'package:flutter_application/loginHome.dart';
import 'package:flutter_application/signIn.dart';

class firstScreen extends StatelessWidget {
  const firstScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const firstScreenContent(),
        '/loginHome': (context) => const LoginHome(),
        '/signIn': (context) => const SignInApp(),
      },
    );
  }
}

class firstScreenContent extends StatelessWidget {
  const firstScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ND TELEMEDICINE'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "TD Telemedicine For Patients",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1603807008857-ad66b70431aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80",
                    fit: BoxFit.fill,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/loginHome');
                  }, // UPDATED
                  child: const Text('Patient Sign In'),
                ),
                Text(
                  "TD Telemedicine For Doctors",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                    fit: BoxFit.fill,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signIn');
                  }, // UPDATED
                  child: const Text('Doctor Sign In'),
                ),
              ],
            ),
          ),
        ));
  }
}
