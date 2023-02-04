import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/ticket_history.dart';
import 'package:mobil_app_bus/src/services/tickes_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  Future<List<TicketHistory>>? ticketHistoryList =
      [] as Future<List<TicketHistory>>?;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticketHistoryList = getTicketsListByIdClient();
  }

  Future<List<TicketHistory>> getTicketsListByIdClient() async {
    final prefs = await SharedPreferences.getInstance();
    final String clientId = prefs.getString("key_client_id") ?? "";
    var response = await TicketsServices().getTicketsListByIdClient(clientId);
    return response;
  }
}
