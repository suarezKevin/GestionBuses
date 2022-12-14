import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //home:
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
      },
    );
  }
}
