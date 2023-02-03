import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.center, child: Text('Tickets - Historial')),
        backgroundColor: HexColor("#000080"),
      ),
      body: const Center(
        child: Text('Presentacion de tickets'),
      ),
    );
  }
}
