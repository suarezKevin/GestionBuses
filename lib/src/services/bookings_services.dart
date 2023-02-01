import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobil_app_bus/src/models/bus_ticket.dart';

class BookingsServices {
  Future generateBookings(BusTicket busTicket) async {
    try {
      var url =
          Uri.parse('http://192.168.0.101:8090/bus_link/api/protected/tickets');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(busTicket.toJson()),
      );
      print(response);

      if (response.statusCode == 201) {
        final body = utf8.decode(response.bodyBytes);
        final mapDatos = jsonDecode(body);

        print(mapDatos);
        //print(buselement.length);
        return mapDatos;
      } else {
        final body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> mapDatos = jsonDecode(body);
        //print("${mapDatos['message']}");
        return mapDatos;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
