import 'package:flutter/material.dart';
import 'package:mobil_app_bus/src/models/bus_frecuencies.dart';

class TicketInformationPage extends StatefulWidget {
  TicketInformationPage({super.key, this.busFrecuencies});
  BusFrecuencies? busFrecuencies;

  @override
  State<TicketInformationPage> createState() => _TicketInformationPageState();
}

class _TicketInformationPageState extends State<TicketInformationPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Información'),
        ),
        body: Column(
          children: [
            Text(widget.busFrecuencies!.cooperativeName.toString()),
            Text(widget.busFrecuencies!.busNumber.toString()),
            Text(widget.busFrecuencies!.type.toString()),
          ],
        ),
      ),
    );
  }
}
