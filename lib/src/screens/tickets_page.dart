import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/ticket_history.dart';
import 'package:mobil_app_bus/src/screens/home_page.dart';
import 'package:mobil_app_bus/src/services/tickes_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  int _selected_index = 0;
  Future<List<TicketHistory>>? ticketHistoryList;
  String? asSeatStringList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
            alignment: Alignment.center, child: Text('Tickets - Historial')),
        backgroundColor: HexColor("#000080"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: ticketHistoryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TicketHistory> data =
                      snapshot.data as List<TicketHistory>;
                  if (data.isEmpty) {
                    return Column(children: const [
                      Text(
                        "¡Historial de Tickets vacio!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Aun no realiza una compra.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]);
                  }
                  return Expanded(
                    child: ListView(
                      children: showTicketHistoryList(data),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("¡Error al cargar los tickets!");
                }
                return Align(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: HexColor("#4169E1"),
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_membership_outlined,
              color: HexColor("#4169E1"),
            ),
            label: "Tickets",
          ),
        ],
        onTap: _pageSelect,
        currentIndex: _selected_index,
      ),
    );
  }

  void _pageSelect(int index) {
    setState(() {
      _selected_index = index;
      print(_selected_index);
      switch (_selected_index) {
        case 0:
          print("0");
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        case 1:
          print("1");
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TicketsPage()),
          );
          break;

        default:
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selected_index = 1;
    ticketHistoryList = getTicketsListByIdClient();
  }

  Future<List<TicketHistory>> getTicketsListByIdClient() async {
    final prefs = await SharedPreferences.getInstance();
    final String clientId = prefs.getString("key_client_id") ?? "";
    var response = await TicketsServices().getTicketsListByIdClient(clientId);
    return response;
  }

  List<Widget> showTicketHistoryList(List<TicketHistory> data) {
    List<Widget> tickets = [];
    List<int> seatList = [];
    for (var element in data) {
      for (var seat in element.seatings!) {
        seatList.add(seat.number!);
        asSeatStringList = seatList.join(", ");
      }
      tickets.add(
        Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 15,
          child: Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 0, top: 0, right: 15, bottom: 0),
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.only(
              //       bottomLeft: Radius.circular(5),
              //     ),
              //     // ignore: unnecessary_null_comparison
              //     child: imageBytes != null
              //         ? Image.memory(imageBytes,
              //             width: 120, height: 120, fit: BoxFit.fill)
              //         : Image.asset("assets/images/imglogin.jpeg",
              //             width: 120, height: 120, fit: BoxFit.fill),
              //     //color: Colors.red,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element.cooperative.toString(), //nombre Cooperativa
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: HexColor("#4169E1"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Cédula: ${element.ci}", // origen del viaje
                    ),
                    Text(
                      "Pasajero: ${element.full_name}", // destino del viaje
                    ),
                    Text(
                      "Celular: ${element.phone}", // precio del viaje
                    ),
                    Text(
                      "Email: ${element.email}", // duracion del viaje
                    ),
                    Text(
                      "N° Bus: ${element.busNumber}", // Tipo de viaje
                    ),
                    Text(
                      "Origen: ${element.origen}", // Tipo de viaje
                    ),
                    Text(
                      "Destino: ${element.destiny}", // Tipo de viaje
                    ),
                    Text(
                      "Salida: ${element.departureTime}", // Tipo de viaje
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "N° Asientos: $asSeatStringList", // Tipo de viaje
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Costo Total: ${element.price?.toStringAsFixed(2)}", // Tipo de viaje
                    ),
                    Text(
                      "Estado: ${element.status}", // Tipo de viaje
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      seatList.clear();
    }
    return tickets;
  }
}
