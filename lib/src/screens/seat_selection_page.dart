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
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: seatList!.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //           title: Text(seatList[index].number.toString()));
              //     },
              //   ),
              // )
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: List.generate(seatList!.length, (index) {
                    return Center(
                      child: Text(
                        seatList[index].number.toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
