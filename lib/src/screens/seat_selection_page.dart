import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/bus_frecuencies.dart';

class SeatSelectionPage extends StatefulWidget {
  SeatSelectionPage({super.key, this.busFrecuencies});
  BusFrecuencies? busFrecuencies;

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<int> numberSeatList = [];
  List<int> numberOccupiedSeatList = [];
  String asStringList = "";

  @override
  Widget build(BuildContext context) {
    List<Seating>? seatList = widget.busFrecuencies?.seating;
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.center,
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
                Text(asStringList), //cantidad de asientos
              ]),
            ),
            Column(children: [
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
                padding: const EdgeInsets.all(10.0),
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
                              chooseSeat(
                                  context, seatList[index].number.toString());
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
              margin: EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Confirmar",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 15,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 45),
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
    );
  }

  void chooseSeat(BuildContext context, String number) {
    if (numberOccupiedSeatList.contains(int.parse(number))) {
      _showOccupiedSeatMessage(context);
    } else {
      if (numberSeatList.contains(int.parse(number))) {
        _showAddNumberMessage(context);
      } else {
        numberSeatList.add(int.parse(number));
        setState(() {
          asStringList = numberSeatList.join(", ");
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
}
