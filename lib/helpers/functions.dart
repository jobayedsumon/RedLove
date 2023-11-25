import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user') != null;
}

getUser() async {
  final prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  return jsonDecode(user!);
}

setUser(String user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', user);
}

logout(context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('user');
  GoogleSignIn().disconnect();
  Navigator.pushNamedAndRemoveUntil(
      context, '/login', (Route<dynamic> route) => false);
}
