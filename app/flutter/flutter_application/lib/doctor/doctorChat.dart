import 'package:flutter/material.dart';
import 'package:flutter_application/doctor/core/api_chat.dart';

import 'model/chatModel.dart';

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
  var testPatients = {"Hellen": 23, "Dave": 22, "John": 21, "Rose": 25};

  final chatApiClient _apiClient = chatApiClient();
  String? _dropdownValue;
  int senderId = 24;
  List<Widget> chatMessagesWidget = [];

  _doctorChatContentState() {
    _dropdownValue = testPatients.values.first.toString();
  }
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
    List<DropdownMenuItem<String>> returnVal = [];
    testPatients.entries.forEach((element) => {
          returnVal.add(
            DropdownMenuItem<String>(
              value: element.value.toString(),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  element.key,
                ),
              ),
            ),
          )
        });

    return returnVal;
  }

  void onDropdownChange(String? value) async {
    setState(() {
      _dropdownValue = value!;
    });
    try {
      List<Widget> data = await chatBoxes(senderId, int.parse(value!));
      setState(() {
        chatMessagesWidget = data;
      });
    } catch (ex) {
      print("ERROR:");
      print(ex);
    }
  }

  Widget generateChatMessage(String message, bool received) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (received ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (received ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  Future<List<Widget>> chatBoxes(
      int senderIdNumber, int receiverIdNumber) async {
    //Styling for text box from https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
    chatModel chatModelResult =
        await _apiClient.getChats(senderIdNumber, receiverIdNumber);

    List<Widget> returnVal = [];

    chatModelResult.getChats().forEach((result) =>
        {returnVal.add(generateChatMessage(result.getMessage(), false))});

    print("returning chat boxes of length: " + returnVal.length.toString());
    return returnVal;
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
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Column(
                      children: [
                        //Received/sent messages
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: SingleChildScrollView(
                              child: Column(
                            children: chatMessagesWidget,
                          )),
                        ),
                        const Spacer(),

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
