import 'package:flutter/material.dart';
import 'welcome.dart';

class DoctorSignUpScreen extends StatelessWidget {
  const DoctorSignUpScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Registration'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 600,
          child: Card(
            child: DoctorSignUpForm(),
          ),
        ),
      ),
    );
  }
}

class DoctorSignUpForm extends StatefulWidget {
  const DoctorSignUpForm();

  @override
  _DoctorSignUpFormState createState() => _DoctorSignUpFormState();
}

class _DoctorSignUpFormState extends State<DoctorSignUpForm> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _ConfirmPwTextController = TextEditingController();
  final _UniqueIdTextController = TextEditingController();

  double _formProgress = 0;

  void _validateForm() {
    // todo: validate method & backend stuff for doctor registration

    String usernameString = _usernameTextController.value.text;
    String passwordString = _passwordTextController.value.text;

    if (1 == 2) {
      Navigator.of(context).pushNamed('/welcome');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Cannot Sign Up'),
                content: const Text('Error'),
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
      _ConfirmPwTextController,
      _UniqueIdTextController,
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
            Text('Doctor Sign Up',
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
            // todo: method for confirming password
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _ConfirmPwTextController,
                decoration: const InputDecoration(hintText: 'Confirm Password'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _UniqueIdTextController,
                decoration: const InputDecoration(
                    hintText:
                        'Doctor Unique ID (something idk for verification)'),
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
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
