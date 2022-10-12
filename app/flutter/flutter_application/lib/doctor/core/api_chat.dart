import 'package:flutter_application/doctor/model/chatModel.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

class chatApiClient {
  // Return an instance of PatientModel
  Future<chatModel> getChats(String sender, String recipient) async {
    Response response =
        await http.get(Uri.parse('http://localhost:8089/chat/'));
    if (response.statusCode == 200) {
      return PatientModel.fromJson(jsonDecode((response.body)));
    } else {
      throw Exception('Failed to load userdata');
    }
  }
}
