import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../global_config.dart';
import '../model/user_model.dart';

ValueNotifier<UserModel> currentUser = new ValueNotifier(UserModel());

Future<UserModel> login(UserModel user) async {
  print(user);
  print("\n");
  String url = baseUrl + "login";

  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJSON()));

  if (res.statusCode == 200) {
    final user = json.decode(res.body)['user'];

    int dataRes = user.length;
    if (dataRes > 0) {
      setCurrentUser(user); // set to SharedPref
      currentUser.value = UserModel.fromJson(user); // set to ValueNotifier
    }
  } else {}
  return currentUser.value;
}

void setCurrentUser(jsonString) async {
  var user = jsonString;
  print(user);
  try {
    if (jsonString != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(jsonString));
      print(prefs.getString("current_user"));
    }
  } catch (e) {
    print(e);
  }
}

Future<UserModel> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userPref = await prefs.get('current_user');
  if (prefs.containsKey('current_user')) {
    currentUser.value = UserModel.fromJson(json.decode(userPref.toString()));
  }
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<void> logout() async {
  currentUser.value = new UserModel();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}
