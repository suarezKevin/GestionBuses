import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobil_app_bus/src/models/bus_frecuencies.dart';

class BusFrequenciesServices {
  Future getListBusFrecuencies(String origin, String destiny) async {
    try {
      var data = {"origen": origin, "destiny": destiny};
      var url = Uri.parse(
          'https://buslink-backend-production.up.railway.app/bus_link/api/protected/itineraries/find');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      print(response);
      List<BusFrecuencies> frecuenciesList = [];
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final mapDatos = jsonDecode(body);
        for (var element in mapDatos["data"]) {
          List<Seating> seatList = [];
          for (var seating in element["bus"]["seating"]) {
            seatList.add(
              Seating(
                  number: seating["number"],
                  type: seating["type"],
                  status: seating["status"]),
            );
          }
          frecuenciesList.add(BusFrecuencies(
              idBus: element["bus"]["id"],
              cooperativeName: element["bus"]["cooperative"]["name"],
              image: element["bus"]["cooperative"]["image"],
              origin: element["frequency"]["origen"],
              destiny: element["frequency"]["destiny"],
              price: element["frequency"]["price"],
              vipPrice: element["bus"]["vipPrice"],
              type: element["frequency"]["type"],
              brand: element["bus"]["brand"],
              model: element["bus"]["model"],
              plate: element["bus"]["plate"],
              chassis: element["bus"]["chassis"],
              minutes: element["frequency"]["minutes"],
              hours: element["frequency"]["hours"],
              departureTime: element["departureTime"],
              busNumber: element["bus"]["busNumber"],
              stops: element["frequency"]["stops"],
              seating: seatList));
        }
        print("saludos");
        print(frecuenciesList.length);
        print(mapDatos);
        //print(buselement.length);
        return frecuenciesList;
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
