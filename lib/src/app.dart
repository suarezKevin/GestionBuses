import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/screens/home_page.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:mobil_app_bus/src/screens/register_user.dart';
import 'package:mobil_app_bus/src/screens/seat_selection_page.dart';
import 'package:mobil_app_bus/src/screens/ticket_information_page.dart';

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
            return const LoginPage();
          } else {
            return const HomePage();
          }
        },
        "/register": (context) => const RegisterPage(),
        "/home_page": (context) => const HomePage(),
        "/ticket_information_page": (context) => TicketInformationPage(),
        "/seat_selection_page": (context) => const SeatSelectionPage(),
      },
    );
  }
}
