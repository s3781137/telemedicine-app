import 'package:flutter/material.dart';

const List<String> testPatients = <String>["Hellen", "Dave", "John", "Rose"];

class doctorChat extends StatelessWidget {
  const doctorChat();

  @override
  Widget build(BuildContext context) {
    return doctorChatContent();
  }
}

class doctorChatContent extends StatefulWidget {
  const doctorChatContent();

  @override
  _doctorChatContentState createState() => _doctorChatContentState();
}

class _doctorChatContentState extends State<doctorChatContent> {
  //For testing

  String _dropdownValue = testPatients.first;

  //Gets a list of the patients
  List<DropdownMenuItem<String>> retrievePatients() {
    //This is dummy code that needs to be implemented with db items

    /*
    List<DropdownMenuItem<String>> returnVal = [];
    for (String patients in testPatients) {
      var newItem = DropdownMenuItem<String>(
        value: patients,
        child: Text(patients),
      );
      returnVal.add(newItem);
    }
    */

    return testPatients.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            value,
          ),
        ),
      );
    }).toList();
  }

  void onDropdownChange(String? value) {
    setState(() {
      _dropdownValue = value!;
    });
  }

  List<Widget> chatBoxes() {
    //Styling for text box from https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
    return ([
      Container(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        child: Align(
          alignment: (Alignment.topLeft),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Test Message",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ND TELEMEDICINE'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Select a patient:",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    //Makes the dropdown bigger
                    width: 200,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: retrievePatients(),
                      value: _dropdownValue,
                      onChanged: onDropdownChange,
                    ),
                  ),
                  //Container for the chat
                  Container(
                    //Sets the width to 80% of screen width
                    width: MediaQuery.of(context).size.width * 0.8,
                    //Sets height to 60% of screen height
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Column(
                      children: [
                        //Received/sent messages
                        SingleChildScrollView(
                            child: Column(
                          children: chatBoxes(),
                        )),
                        //Input box to send messages
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Message:'),
                                  keyboardType: TextInputType.multiline,
                                  minLines: 2,
                                  maxLines: 2),
                            ),
                            //Button to submit (onpressed needs to be implemented)
                            TextButton(
                                onPressed: () => {null},
                                child: const Text("Submit"))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
