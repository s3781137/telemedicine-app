import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class firstScreen extends StatelessWidget {
  const firstScreen();

  @override
  Widget build(BuildContext context) {
    return firstScreenContent();
  }
}

class firstScreenContent extends StatelessWidget {
  const firstScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //App bar
        appBar: AppBar(
          title: Text('ND TELEMEDICINE'),
          centerTitle: true,
        ),
        // Setting the background color
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Label for picture
                Text(
                  "TD Telemedicine For Patients",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                // Picture
                Container(
                  //Padding for top and bottom
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //Sets the height of the picture to be half of the screen height
                  height: MediaQuery.of(context).size.height / 2,
                  //Gets the image from the internet
                  //Photo by Derek Finch sourced from unisplash https://unsplash.com/photos/zkrPU_1AwdU
                  child: Image.network(
                    "https://images.unsplash.com/photo-1603807008857-ad66b70431aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80",
                    fit: BoxFit.fill,
                  ),
                ),
                //Button to route
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    //Navigator
                    Navigator.of(context).pushNamed('/loginhome');
                  },
                  child: const Text('Patient Sign In'),
                ),
                //Label for image
                Text(
                  "TD Telemedicine For Doctors",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                //Image
                Container(
                  //Padding for top and bottom
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //Sets height to half of screen height
                  height: MediaQuery.of(context).size.height / 2,
                  //Gets image from internet
                  //Image taken by National Cancer Institute and sourced from Unsplash https://unsplash.com/photos/L8tWZT4CcVQ
                  child: Image.network(
                    "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                    fit: BoxFit.fill,
                  ),
                ),
                //Button for routing
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    //Navigator
                    if (currentLoggedInUser["username"] != "" &&
                        currentLoggedInUser["userType"] == "doctor") {
                      Navigator.of(context).pushNamed('/welcome');
                    } else {
                      Navigator.of(context).pushNamed('/doctorsignin');
                    }
                  },
                  child: const Text('Doctor Sign In'),
                ),
              ],
            ),
          ),
        ));
  }
}
