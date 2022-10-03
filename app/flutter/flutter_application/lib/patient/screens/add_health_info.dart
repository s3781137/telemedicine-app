import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';
import '../patient.dart';

class PatientHealthInfo extends StatelessWidget {
  String username;
  PatientHealthInfo({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ND TELEMEDICINE'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: PopupMenuButton(
                child: Icon(Icons.account_circle),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'logout',
                      child: Text('Log out'),
                    ),
                    PopupMenuItem(
                      value: 'changePW',
                      child: Text('Change Password'),
                    ),
                    PopupMenuItem(
                      value: 'rmAccount',
                      child: Text('Delete account'),
                    ),
                  ];
                },
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // todo debug msg
                  print("passed username: $username");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Patient(username: username)));
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: HealthInfo(),
    );
  }
}

class HealthInfo extends StatefulWidget {
  HealthInfo({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HealthInfoState createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConditionalQuestions(
        key: _key,
        children: questions(),
        trailing: [
          MaterialButton(
            color: Colors.deepOrange,
            splashColor: Colors.orangeAccent,
            onPressed: () async {
              if (_key.currentState!.validate()) {
                print("validated!");
              }
            },
            child: Text("Submit"),
          )
        ],
        leading: [Text("TITLE")],
      ),
    );
  }
}

List<Question> questions() {
  return [
    Question(
      question: "What is your name?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    NestedQuestion(
        question: "Are you on any medications?",
        answers: ["Yes", "No"],
        children: {
          'Yes': [
            Question(
              question: "Comments",
            ),
          ],
        },
        isMandatory: true),
    PolarQuestion(question: "Liver disease?", answers: ["Yes", "No"]),
    PolarQuestion(question: "Kidney Disease?", answers: ["Yes", "No"]),
    PolarQuestion(question: "Heart Disease?", answers: ["Yes", "No"]),
    PolarQuestion(question: "Diabetes?", answers: ["Yes", "No"]),
    PolarQuestion(question: "Cancers?", answers: ["Yes", "No"]),
    Question(question: "Any other medical problems or allergies?"),
    Question(question: "Any past surgeries or hospitalisations?"),
  ];
}
