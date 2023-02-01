import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/bus_frecuencies.dart';
import 'package:mobil_app_bus/src/screens/seat_selection_page.dart';

class TicketInformationPage extends StatefulWidget {
  TicketInformationPage({super.key, this.busFrecuencies});
  BusFrecuencies? busFrecuencies;

  @override
  State<TicketInformationPage> createState() => _TicketInformationPageState();
}

class _TicketInformationPageState extends State<TicketInformationPage> {
  String travelType = "";

  @override
  Widget build(BuildContext context) {
    travelType =
        (widget.busFrecuencies!.type.toString() == "DIRECTO") ? "Si" : "No";
    Uint8List? imageBytes;
    imageBytes =
        const Base64Decoder().convert(widget.busFrecuencies!.image.toString());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 1),
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Boleto - Información')),
        backgroundColor: HexColor("#000080"),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                width: 300,
                height: 280,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                  ),
                  // ignore: unnecessary_null_comparison
                  child: imageBytes != null
                      ? Image.memory(imageBytes,
                          width: 120, height: 120, fit: BoxFit.fill)
                      : Image.asset("assets/images/imglogin.jpeg",
                          width: 120, height: 120, fit: BoxFit.fill),
                  //color: Colors.red,
                ),
              ),
            ),
            Text(
              widget.busFrecuencies!.cooperativeName.toString(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: HexColor("#4169E1"),
              ),
            ),
            //Despues dell Titulo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Column(
                    children: [
                      const Text("Detalle Viaje"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Origen: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.origin.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Destino: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.destiny.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "N° de Bus: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.busNumber.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Duración: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "${widget.busFrecuencies!.hours}h:${widget.busFrecuencies!.minutes}m",
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Precio: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "\$${widget.busFrecuencies!.price.toString()}",
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Viaje Directo: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              travelType,
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Salida: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.departureTime.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                    ],
                  ),
                ),
                //Segunda Columna
                Container(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Column(
                    children: [
                      Text("Info. Bus"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "N° Bus: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.busNumber.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Placa: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.plate.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Marca: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.brand.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Modelo: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.model.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Chasis: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.busFrecuencies!.chassis.toString(),
                              style: const TextStyle(fontSize: 20),
                            )
                          ]),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showConfirmDialog();
                    },
                    child: const Text(
                      "Iniciar Compra",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      returnHome();
                    },
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  void showConfirmDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar para Iniciar Compra"),
          content: Text(
            "¿Desea continuar con la compra del boleto?",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            Align(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text(
                    "Aceptar",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SeatSelectionPage(
                                busFrecuencies: widget.busFrecuencies,
                              )),
                    );
                  },
                ),
                TextButton(
                  child: Text(
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

  void returnHome() {
    Navigator.pop(context);
  }
}
