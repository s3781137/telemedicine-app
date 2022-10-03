import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter_application/patient/model/petient_health_model.dart';
import '../core/api_patient.dart';
import '../patient.dart';

class PatientHealthInfo extends StatelessWidget {
  int id;
  PatientHealthInfo({Key? key, required this.id}) : super(key: key);

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
                  print("passed user id healthinfo: $id");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Patient(id: id)));
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: HealthInfo(
        id: id,
      ),
    );
  }
}

class HealthInfo extends StatefulWidget {
  HealthInfo({Key? key, this.id}) : super(key: key);

  int? id;

  @override
  _HealthInfoState createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  final _key = GlobalKey<QuestionFormState>();
  final ApiClient _apiClient = ApiClient();

  Future<void> updateHealthInfo(int? id) async {
    // todo: debug message
    print("method id:$id");
    // todo: condition missing

    PatientHealthModel healthInfo = PatientHealthModel(
        id: id,
        cancer: _key.currentState!.getElementList().elementAt(6).answer,
        diabetes: _key.currentState!.getElementList().elementAt(5).answer,
        heartDisease: _key.currentState!.getElementList().elementAt(4).answer,
        kidneyDisease: _key.currentState!.getElementList().elementAt(3).answer,
        liverDisease: _key.currentState!.getElementList().elementAt(2).answer,
        medicalProblems:
            _key.currentState!.getElementList().elementAt(7).answer,
        medication: _key.currentState!.getElementList().elementAt(0).answer,
        medicationDescription:
            _key.currentState!.getElementList().elementAt(1).answer,
        pastSurgeries: _key.currentState!.getElementList().elementAt(8).answer);
    dynamic res = await _apiClient.updateHealthInfo(healthInfo);
    print(res);
    // todo: maybe need to fix condition
    if (res.toString().contains("health information registered")) {
      print("updated health info for :$id");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Update Failure'),
                content: const Text('Cannot update health information'),
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
              updateHealthInfo(widget.id);
            },
            child: Text("Test Submit"),
          ),
          // todo: remove button for debug
          MaterialButton(
              child: Text("debug"),
              onPressed: () {
                if (_key.currentState!.getElementList().elementAt(1).question ==
                    "Comments") {
                  for (int i = 0; i < 9; ++i) {
                    print(
                        "returned list of survey$i: ${_key.currentState!.getElementList().elementAt(i).question}");
                    print(
                        "returned list of survey$i: ${_key.currentState!.getElementList().elementAt(i).answer}");
                  }
                } else {
                  for (int i = 0; i < 8; ++i) {
                    print(
                        "returned list of survey$i: ${_key.currentState!.getElementList().elementAt(i).question}");
                    print(
                        "returned list of survey$i: ${_key.currentState!.getElementList().elementAt(i).answer}");
                  }
                }
              })
        ],
        leading: [Text("TITLE")],
      ),
    );
  }
}

List<Question> questions() {
  return [
    NestedQuestion(
        question: "Are you on any medications?",
        answers: ["Yes", "No"],
        children: {
          'Yes': [
            Question(
              question: "Comments",
              validate: (field) {
                if (field.isEmpty) return "Field cannot be empty";
                return null;
              },
            ),
          ],
        },
        isMandatory: true),
    PolarQuestion(
        question: "Liver disease?", answers: ["Yes", "No"], isMandatory: true),
    PolarQuestion(
        question: "Kidney Disease?", answers: ["Yes", "No"], isMandatory: true),
    PolarQuestion(
        question: "Heart Disease?", answers: ["Yes", "No"], isMandatory: true),
    PolarQuestion(
        question: "Diabetes?", answers: ["Yes", "No"], isMandatory: true),
    PolarQuestion(
        question: "Cancers?", answers: ["Yes", "No"], isMandatory: true),
    Question(
      question: "Any other medical problems or allergies?",
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    Question(
      question: "Any past surgeries or hospitalisations?",
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
  ];
}
