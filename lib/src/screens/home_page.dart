import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("key_token", "");
                  prefs.setString("key_email", "");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                icon: Icon(
                  Icons.logout,
                ))
          ],
        ),
        body: const Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
