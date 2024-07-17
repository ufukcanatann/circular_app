import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Classes/Users.dart';

Future<Users> getSessionData() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;
  Users useraa;
  Map<String, dynamic> userMap = jsonDecode(prefs.getString('user').toString());
  useraa = Users.fromJson(userMap);
  return useraa;
}
