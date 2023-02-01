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
  @override
  Widget build(BuildContext context) {
    List<Seating>? seatList = widget.busFrecuencies?.seating;
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.center,
              child: const Text('Selección Asiento - Boleto')),
          backgroundColor: HexColor("#000080"),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Row(children: [
                  Text(
                    "N° de Asientos Seleccionados: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(""), //cantidad de asientos
                ]),
              ),
              Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 5, right: 15),
                      child: Row(children: [
                        Text("Libre: "),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.blue),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, right: 10),
                      child: Row(children: [
                        Text("Ocupado: "),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.red),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 45, top: 5, right: 15),
                      child: Row(children: [
                        Text("Normal: "),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.black),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, right: 10),
                      child: Row(children: [
                        Text("VIP: "),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
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
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onDoubleTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    color: seatList[index].status.toString() ==
                                            "OCUPADO"
                                        ? Colors.red
                                        : Colors.blue),
                                padding: EdgeInsets.all(15),
                                child: Row(children: [
                                  Icon(Icons.chair_sharp,
                                      color: seatList[index].type.toString() ==
                                              "VIP"
                                          ? Colors.yellowAccent[700]
                                          : Colors.black),
                                  Text(
                                    seatList[index].number.toString(),
                                    style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
