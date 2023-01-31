import 'package:flutter/material.dart';

void main() => runApp(const SeatSelectionPage());

class SeatSelectionPage extends StatelessWidget {
  const SeatSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Seleccion de Asientos'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
