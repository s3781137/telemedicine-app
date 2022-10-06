import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

//TODO: connect backend with login and stop using the passwords dict
//Test key, values for username and password
var passwords = {"test": "Password123", "oli": "helloWorld!"};

class SignInApp extends StatelessWidget {
  const SignInApp();

  @override
  Widget build(BuildContext context) {
    return const SignInScreen();
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        title: const Text("ND TELEMEDICINE"),
        centerTitle: true,
      ),
      //Sets the background colour
      backgroundColor: Colors.grey[200],
      //Centers the content
      body: const Center(
        child: SizedBox(
          //Sets the width
          width: 600,
          child: Card(
            child: SignInForm(),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm();

  //Creates a stateful widget
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  //For managing the text inputs
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  //For keeping track of what fields have had values in them
  double _formProgress = 0;

  //Is called when we change one of these fields
  void _validateForm() {
    //Stores the values in string variables
    String usernameString = _usernameTextController.value.text;
    String passwordString = _passwordTextController.value.text;

    //Checking if username and password match
    if (passwords[usernameString] == passwordString) {
      // TODO: sign in to doctor homepage
      //Updates logged in user
      currentLoggedInUser.update("username", (value) => usernameString);
      currentLoggedInUser.update("userType", (value) => "doctor");
      //Navigates to the welcome page
      Navigator.of(context).pushNamed('/welcome');
    } else {
      //If not show popup error
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Cannot Sign in'),
                content: const Text('Username and Password do not match'),
                actions: <Widget>[
                  TextButton(
                    //On pressed remove the dialog box
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ]);
          });
    }
  }

  //Updates the form progress
  void _updateFormProgress() {
    //Initialises it to zero
    var progress = 0.0;
    //defines each controler
    final controllers = [
      _usernameTextController,
      _passwordTextController,
    ];

    //Iterates through each controler, checking if empty and incrementing if it is not empty
    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1;
      }
    }
    //Makes progress now store the percentage of the form completed
    progress = progress / controllers.length;

    //Updates the formprogress state
    setState(() {
      _formProgress = progress;
    });
  }

  // doctor sign up button
  Widget doctorSignUpButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/doctorsignup'),
          child: const Text('Sign Up'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //Adds padding to the whole thing
      padding: const EdgeInsets.all(20),
      child: Form(
        //Calls the _updateFormProgress function whenever the form is updated
        onChanged: _updateFormProgress,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Shows how much of the form progress is completed
            LinearProgressIndicator(value: _formProgress),
            //Title
            Text('Doctor Sign In',
                style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              //The username textbox with hint text
              child: TextFormField(
                controller: _usernameTextController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              //The password textbox with hint text
              child: TextFormField(
                //Defines the controler to the one we set before
                controller: _passwordTextController,
                decoration: const InputDecoration(hintText: 'Password'),
                //Obscures the text becasue it is a password
                obscureText: true,
              ),
            ),
            ElevatedButton(
              //Only activates when formProgress is fulls
              onPressed: _formProgress == 1 ? _validateForm : null, // UPDATED
              child: const Text('Sign In'),
            ),
            doctorSignUpButton(context),
          ],
        ),
      ),
    );
  }
}
