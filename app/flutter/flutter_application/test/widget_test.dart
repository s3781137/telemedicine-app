// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application/patient/core/api_patient.dart';

void main() {
  test('Incorect password should reject', () async {
    final api = ApiClient();
    var res = await api.login("incorrectLogin", "incorrectPassword");
    expect(res, null);
  });

  test("No password should reject", () async {
    final api = ApiClient();
    var res = await api.login("username", "");
    expect(res, null);
  });

  test("No username should reject", () async {
    final api = ApiClient();
    var res = await api.login("", "password");
    expect(res, null);
  });

  test("No username or password should reject", () async {
    final api = ApiClient();
    var res = await api.login("", "");
    expect(res, null);
  });

  test("Fetch users should not throw exception", () async {
    final api = ApiClient();
    await api.fetchUsers();
    //Will throw expeption on error
  });

  test("Get user that exists should not throw an exeption", () async {
    final api = ApiClient();
    //The user "test" should be in the database for this to work
    await api.getUser("test");
    //Will throw expeption on error
  });

  test("Get user that doesnt exist should throw an exeption", () async {
    final api = ApiClient();
    expect(() => api.getUser(""), throwsException);
  });

  test("Get user that doesnt exist should throw an exeption", () async {
    final api = ApiClient();
    expect(() => api.getUser(""), throwsException);
  });

  test("Register user that exists should throw an exeption", () async {
    final api = ApiClient();
    //The user "test" should be in the database for this to work
    //Will throw expeption on error
    expect(
        () async => await api.register("test", "password", "password",
            "firstName", "lastName", "email@email.com"),
        throwsException);
  });
}
