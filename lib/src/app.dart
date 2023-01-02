import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/screens/home_page.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:mobil_app_bus/src/screens/register_user.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.existEmail});
  final String? existEmail;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      //home:
      initialRoute: "/",
      routes: {
        "/": (context) {
          if (existEmail!.isEmpty) {
            return LoginPage();
          } else {
            return HomePage();
          }
        },
        "/register": (context) => RegisterPage(),
        "/home_page": (context) => HomePage(),
      },
    );
  }
}
