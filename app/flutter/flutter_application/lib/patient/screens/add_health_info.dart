import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter_application/patient/model/petient_health_model.dart';
import '../../main.dart';
import '../core/api_patient.dart';
import '../patient.dart';

class PatientHealthInfo extends StatelessWidget {
  PatientHealthInfo({Key? key}) : super(key: key);

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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Patient()));
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
  HealthInfo({
    Key? key,
  }) : super(key: key);

  @override
  _HealthInfoState createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  final _key = GlobalKey<QuestionFormState>();
  final ApiClient _apiClient = ApiClient();
  int lineCancer = 6;
  int lineDiabetes = 5;
  int lineHeartDisease = 4;
  int lineKidneyDisease = 3;
  int lineLiverDisease = 2;
  int lineMedicalProblems = 7;
  int lineMedication = 0;
  int lineMedicationDescpt = 1;
  int linePastSurgeries = 8;
  int? id = -1;
  Future<void> updateHealthInfo(dynamic username) async {
    id = await _apiClient.getUserId(username);
    // todo: debug message
    print(id);
    // check the first question is yes or no
    if (!(_key.currentState!.getElementList().elementAt(1).question ==
        "Comments")) {
      lineCancer -= 1;
      lineDiabetes -= 1;
      lineHeartDisease -= 1;
      lineKidneyDisease -= 1;
      lineLiverDisease -= 1;
      lineMedicalProblems -= 1;
      linePastSurgeries -= 1;
      lineMedicationDescpt = 0;
    }
    PatientHealthModel healthInfo = PatientHealthModel(
        id: id as int?,
        cancer:
            _key.currentState!.getElementList().elementAt(lineCancer).answer,
        diabetes:
            _key.currentState!.getElementList().elementAt(lineDiabetes).answer,
        heartDisease: _key.currentState!
            .getElementList()
            .elementAt(lineHeartDisease)
            .answer,
        kidneyDisease: _key.currentState!
            .getElementList()
            .elementAt(lineKidneyDisease)
            .answer,
        liverDisease: _key.currentState!
            .getElementList()
            .elementAt(lineLiverDisease)
            .answer,
        medicalProblems: _key.currentState!
            .getElementList()
            .elementAt(lineMedicalProblems)
            .answer,
        medication: _key.currentState!
            .getElementList()
            .elementAt(lineMedication)
            .answer,
        medicationDescription: _key.currentState!
            .getElementList()
            .elementAt(lineMedication)
            .answer,
        pastSurgeries: _key.currentState!
            .getElementList()
            .elementAt(linePastSurgeries)
            .answer);
    dynamic res = await _apiClient.updateHealthInfo(healthInfo);
    print(res);
    // todo: maybe need to fix condition
    if (res.toString().contains("health information registered")) {
      print("updated health info for :${id}");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Update Success'),
                content: const Text('Your health information has been updated'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Patient())),
                    child: const Text('OK'),
                  ),
                ]);
          });
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
              updateHealthInfo(currentLoggedInUser["username"]);
            },
            child: Text("Submit"),
          ),
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
