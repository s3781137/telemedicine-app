import 'package:flutter/material.dart';

var passwords = {"test": "Password123", "oli": "helloWorld!"};

class SignInApp extends StatelessWidget {
  const SignInApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignInScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 600,
          child: Card(
            child: SignInForm(),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome!', style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm();

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  double _formProgress = 0;

  void _validateForm() {
    String usernameString = _usernameTextController.value.text;
    String passwordString = _passwordTextController.value.text;

    if (passwords[usernameString] == passwordString) {
      Navigator.of(context).pushNamed('/welcome');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Cannot Sign in'),
                content: const Text('Username and Password do not match'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ]);
          });
    }
  }

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _usernameTextController,
      _passwordTextController,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        onChanged: _updateFormProgress, // NEW
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(value: _formProgress),
            Text('Doctor Sign In',
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
              onPressed: _formProgress == 1 ? _validateForm : null, // UPDATED
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
