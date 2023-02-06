import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobil_app_bus/src/models/seating.dart';
import 'package:mobil_app_bus/src/models/ticket_history.dart';

class TicketsServices {
  Future getTicketsListByIdClient(String idClient) async {
    try {
      var url = Uri.parse(
          'https://buslink-backend-production.up.railway.app/bus_link/api/protected/tickets/client/$idClient');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List<TicketHistory> ticketHistoryList = [];
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final mapDatos = jsonDecode(body);
        for (var element in mapDatos["data"]) {
          List<Seating> seatList = [];
          for (var seating in element["seatings"]) {
            seatList.add(
              Seating(
                  number: seating["number"],
                  type: seating["type"],
                  status: seating["status"]),
            );
          }
          ticketHistoryList.add(TicketHistory(
            id: element["id"],
            ci: element["client"]["ci"],
            full_name: element["client"]["full_name"],
            phone: element["client"]["phone"],
            email: element["client"]["email"],
            cooperative: element["cooperative"],
            busNumber: element["busNumber"],
            price: element["price"],
            departureTime: element["departureTime"],
            origen: element["origen"],
            destiny: element["destiny"],
            seatings: seatList,
            status: element["status"],
            receipt: element["receipt"],
            qr: element["qr"],
            check: element["check"],
          ));
        }
        print(ticketHistoryList.length);
        print(mapDatos);
        //print(buselement.length);
        return ticketHistoryList;
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

  Future sendReceipt(String ticket_id, File receipt) async {}
}
