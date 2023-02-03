import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/bus_frecuencies.dart';
import 'package:mobil_app_bus/src/models/bus_ticket.dart';
import 'package:mobil_app_bus/src/screens/home_page.dart';
import 'package:mobil_app_bus/src/screens/main_navigator_page.dart';
import 'package:mobil_app_bus/src/services/bookings_services.dart';

class SeatSelectionPage extends StatefulWidget {
  SeatSelectionPage({super.key, this.busFrecuencies, this.client_id});
  BusFrecuencies? busFrecuencies;
  String? client_id;

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<int> numberSeatList = [];
  List<int> numberOccupiedSeatList = [];
  String asSeatStringList = "";
  double total = 0.0;
  double? basePrice = 0.0;
  double? vip = 0.0;
  double? vipPrice = 0.0;

  BusTicket? busTicket;

  @override
  Widget build(BuildContext context) {
    List<Seating>? seatList = widget.busFrecuencies?.seating;
    basePrice = widget.busFrecuencies?.price;
    vip = widget.busFrecuencies?.vipPrice;
    vipPrice = basePrice! + vip!;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 1),
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Selección Asiento - Boleto')),
        backgroundColor: HexColor("#000080"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: Row(children: [
                const Text(
                  "Asientos Seleccionados: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Flexible(child: Text(asSeatStringList)), //cantidad de asientos
              ]),
            ),
            Column(children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 0),
                          child: const Text(
                            "Total a Pagar: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          )),
                      Text("\$${total.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text("Precio Normal: \$$basePrice")),
                      Text("Precio VIP: \$${vipPrice?.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ]),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5, right: 15),
                    child: Row(children: [
                      const Text("Libre: "),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.blue),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 10),
                    child: Row(children: [
                      const Text("Ocupado: "),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.red),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 5, right: 15),
                    child: Row(children: [
                      const Text("Normal: "),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.black),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 10),
                    child: Row(children: [
                      const Text("VIP: "),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.yellowAccent[700]),
                      ),
                    ]),
                  ),
                ],
              )
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 0,
                  crossAxisCount: 4,
                  children: List.generate(seatList!.length, (index) {
                    if (seatList[index].status.toString() == "OCUPADO") {
                      numberOccupiedSeatList
                          .add(int.parse(seatList[index].number.toString()));
                    }
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              chooseSeat(context, seatList[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  color: seatList[index].status.toString() ==
                                          "OCUPADO"
                                      ? Colors.red
                                      : Colors.blue),
                              padding: const EdgeInsets.all(15),
                              child: Row(children: [
                                Icon(Icons.chair_sharp,
                                    color:
                                        seatList[index].type.toString() == "VIP"
                                            ? Colors.yellowAccent[700]
                                            : Colors.black),
                                Text(
                                  seatList[index].number.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _validateFields();
                    },
                    child: const Text(
                      "Confirmar",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 15,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: const AlignmentDirectional(0.1, 0.89),
        child: FloatingActionButton(
          backgroundColor: Colors.green[500],
          onPressed: () {
            clearTotalSeatList();
          },
          elevation: 40,
          child: const Icon(Icons.restart_alt_outlined),
          tooltip: "Reiniciar selección",
        ),
      ),
    );
  }

  void chooseSeat(BuildContext context, Seating seating) {
    if (numberOccupiedSeatList.contains(seating.number)) {
      _showOccupiedSeatMessage(context);
    } else {
      if (numberSeatList.contains(seating.number)) {
        _showAddNumberMessage(context);
      } else {
        numberSeatList.add(seating.number!);
        total += basePrice!;
        if (seating.type.toString() == "VIP") {
          total += vip!;
        }
        setState(() {
          asSeatStringList = numberSeatList.join(", ");
          for (var element in numberSeatList) {
            print(element);
          }
        });
      }
    }
  }

  _showAddNumberMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "¡Ya seleccionaste ese asiento!",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  _showOccupiedSeatMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "¡Ups, Lo sentimos pero este asiento ya está reservado!",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  _validateFields() {
    if (numberSeatList.isEmpty) {
      _showNotChooseSeatMessage(context);
    } else {
      showBookingConfirmDialog(context);
    }
  }

  Future _generateBookings() async {
    busTicket = BusTicket(
        cooperative: widget.busFrecuencies?.cooperativeName.toString(),
        client_id: widget.client_id.toString(),
        busNumber: widget.busFrecuencies?.busNumber,
        price: double.parse(total.toStringAsFixed(2)),
        departureTime: widget.busFrecuencies?.departureTime.toString(),
        origen: widget.busFrecuencies?.origin.toString(),
        destiny: widget.busFrecuencies?.destiny.toString(),
        seatings: numberSeatList);

    var response = await BookingsServices().generateBookings(busTicket!);
    if (response["message"] == "Compra exitosa") {
      showBookingGenerateConfirmDialog(context);
    }
  }

  void clearTotalSeatList() {
    setState(() {
      asSeatStringList = "";
      numberSeatList = [];
      total = 0.00;
    });
  }

  void showBookingConfirmDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Reserva"),
          content: const Text(
            "¡Al presionar en confirmar, generará su reserva y debera subir el comprobante de pago para su verificación y validación!",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            Align(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _generateBookings();
                  },
                ),
                TextButton(
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )),
          ],
        );
      },
    );
  }

  _showNotChooseSeatMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "¡No puede continuar con la compra, primero escoga un asiento!",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void showBookingGenerateConfirmDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reserva Generada"),
          content: const Text(
            "¡Reserva Generada con éxito!",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            Align(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    "Ir a Inicio",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainNavigator()),
                    );
                  },
                ),
              ],
            )),
          ],
        );
      },
    );
  }
}
