import 'package:flutter/cupertino.dart';
import 'package:flutter_application/patient/module/functions.dart';

import '../class/user.dart';

class MainBloc extends ChangeNotifier {
  User? user;
  bool loading = false;
  String? errormsg;

  Future<void> authenticate(
      {required String username, required String pass}) async {
    try {
      loading = true;
      notifyListeners();
      // todo test message
      print('before post method');
      print(username + " before post method");
      Map<String, dynamic> _res = await postMethod(
          api: 'patient/login', body: {"username": username, "password": pass});
      print(username);
      user = User.fromJson(_res);
    } catch (e) {
      errormsg = '$e';
      loading = false;
      notifyListeners();
    }
  }
}
