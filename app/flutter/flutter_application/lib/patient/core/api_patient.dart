import 'package:http/http.dart';

class ApiClient {
  Future<dynamic> login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse('http://localhost:8080/patient/login'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return response.body.toString();

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //           title: const Text('Cannot Sign in'),
        //           content: const Text('Username and Password do not match'),
        //           actions: <Widget>[
        //             TextButton(
        //               onPressed: () => Navigator.pop(context),
        //               child: const Text('OK'),
        //             ),
        //           ]);
        //     });

      }
    } catch (e) {}
  }
}
