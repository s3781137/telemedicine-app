import 'dart:convert';

import 'package:flutter/material.dart';

import 'core/api_patient.dart';

// for test
var passwords = {"test": "Password123", "oli": "helloWorld!", "nic": "nic"};

class RegisterHome extends StatelessWidget {
  const RegisterHome();

  @override
  Widget build(BuildContext context) {
    return const RegisterHomeScreen();
  }
}

class RegisterHomeScreen extends StatelessWidget {
  const RegisterHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ND TELEMEDICINE'),
        centerTitle: true,
      ),
      body: const Center(
        child: SizedBox(
          child: Card(
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _usernameTextController,
      _passwordTextController,
      _confirmPasswordTextController,
      _firstNameTextController,
      _lastNameTextController,
      _emailTextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1;
      }
    }
    progress = progress / controllers.length;

    setState(() {
      _formProgress = progress;
    });
  }

  Future<void> Register() async {
    dynamic res = await _apiClient.register(
        _usernameTextController.text,
        _passwordTextController.text,
        _confirmPasswordTextController.text,
        _firstNameTextController.text,
        _lastNameTextController.text,
        _emailTextController.text);
    if (res == 'true') {
      Navigator.of(context).pushNamed('/loginhome');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Cannot Register'),
                content: const Text('Invalid details'),
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        onChanged: _updateFormProgress, // NEW
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(value: _formProgress),
            Text('Patient Register',
                style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameTextController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordTextController,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _confirmPasswordTextController,
                decoration: const InputDecoration(hintText: 'Confirm Password'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _firstNameTextController,
                decoration: const InputDecoration(hintText: 'First name'),
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _lastNameTextController,
                decoration: const InputDecoration(hintText: 'Last name'),
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailTextController,
                decoration: const InputDecoration(hintText: 'Email'),
                obscureText: false,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.blue;
                }),
              ),
              // onPressed: _formProgress == 1 ? _validateForm : null, // UPDATED
              onPressed: () => {Register()},
              child: const Text('         Register         '),
            ),
            Padding(padding: EdgeInsets.all(20)),
            // TextButton(
            //   style: ButtonStyle(
            //     foregroundColor: MaterialStateProperty.resolveWith(
            //         (Set<MaterialState> states) {
            //       return states.contains(MaterialState.disabled)
            //           ? null
            //           : Colors.white;
            //     }),
            //     backgroundColor: MaterialStateProperty.resolveWith(
            //         (Set<MaterialState> states) {
            //       return states.contains(MaterialState.disabled)
            //           ? null
            //           : Colors.blue;
            //     }),
            //   ),
            //   onPressed: () => Navigator.of(context).pushNamed('/choosesignup'),
            //   // redirect the sign up page
            //   child: const Text('New Member? Sign Up! '),
            // ),
            // Padding(padding: EdgeInsets.all(20)),
          ],
        ),
      ),
    );
  }
}
