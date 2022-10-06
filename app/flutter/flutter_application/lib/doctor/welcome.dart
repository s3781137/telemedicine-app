import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    void logOut() {
      currentLoggedInUser.update("username", (value) => "");
      currentLoggedInUser.update("userType", (value) => "");
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ND TELEMEDICINE'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Text('Welcome! ${currentLoggedInUser["username"]}',
              style: Theme.of(context).textTheme.headline2),
          ElevatedButton(
            //Only activates when formProgress is fulls
            onPressed: logOut,
            child: const Text('Log out'),
          ),
        ]),
      ),
    );
  }
}
