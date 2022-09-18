import 'package:http/http.dart';

class ApiClient {
  Future<dynamic> login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse('http://localhost:8080/patient/login'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return response.body.toString();
      }
    } catch (e) {}
  }
}
