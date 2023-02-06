import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/screens/home_page.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:mobil_app_bus/src/screens/receipt_send_page.dart';
import 'package:mobil_app_bus/src/screens/register_user.dart';
import 'package:mobil_app_bus/src/screens/seat_selection_page.dart';
import 'package:mobil_app_bus/src/screens/ticket_information_page.dart';
import 'package:mobil_app_bus/src/screens/tickets_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.existEmail});
  final String? existEmail;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus-Link',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(229, 228, 226, 1)),

      //home:
      initialRoute: "/",
      routes: {
        "/": (context) {
          if (widget.existEmail!.isEmpty) {
            return const LoginPage();
          } else {
            return const HomePage();
          }
        },
        "/register": (context) => const RegisterPage(),
        "/home_page": (context) => const HomePage(),
        "/ticket_information_page": (context) => TicketInformationPage(),
        "/seat_selection_page": (context) => SeatSelectionPage(),
        "/tickets_page": (context) => TicketsPage(),
        "/receipt_send_page": (context) => ReceiptSendPage(),
      },
    );
  }
}
