import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'consts.dart';

Future<List<Map<String, dynamic>>> getMethod(
    {required String api, required Map<String, String> header}) async {
  header.putIfAbsent('Content-Type', () => 'application/json');
  Uri uri = Uri.parse("$serverIP/$api");
  var res = await http.get(uri, headers: header);
  if (res.statusCode == 200) {
    return ((json.decode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList());
  }
  throw Exception(utf8.decode(res.bodyBytes));
}

Future<Map<String, dynamic>> postMethod(
    {required String api,
    required Map<String, dynamic> body,
    Map<String, String>? header}) async {
  if (header == null)
    header = {"Content-Type": "application/json"};
  else
    header.putIfAbsent('Content-Type', () => 'application/json');
  // todo remove debugmsg
  print('inside post $serverIP/$api');
  print('inside post jsonEncodebody: ${jsonEncode(body)}');
  Uri uri = Uri.parse("$serverIP/$api");
  var res = await http.post(uri, body: jsonEncode(body), headers: header);
  print("res" + res.body);
  // todo: debug msg
  print("inside post status code ${res.statusCode}");
  if (res.statusCode == 200) {
    return json.decode(utf8.decode(res.bodyBytes));
  }
  throw Exception(utf8.decode(res.bodyBytes));
}
