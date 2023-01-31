import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String existEmail = prefs.getString("key_email") ?? "";
  runApp(MyApp(existEmail: existEmail));
}
