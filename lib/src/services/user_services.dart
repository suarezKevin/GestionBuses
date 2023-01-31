import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobil_app_bus/src/models/passenger_account.dart';

class UserServices {
  Future postLogin(String email, String password) async {
    try {
      var data = {'email': email, 'password': password};
      var url = Uri.parse(
          'http://192.168.0.101:8090/bus_link/api/auth/signin/client');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> mapDatos = jsonDecode(body);
        //print(data["data"]["token"]);
        return mapDatos["data"];
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

  Future createAccount(PassengerAccount passengerAccount) async {
    try {
      var url = Uri.parse(
          'http://192.168.0.101:8090/bus_link/api/auth/singup/client');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(passengerAccount.toJson()),
      );

      if (response.statusCode == 201) {
        final body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> mapDatos = jsonDecode(body);
        return mapDatos;
      } else {
        final body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> mapDatos = jsonDecode(body);
        return mapDatos;
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future getUserByEmail(String email) async {
    try {
      var url = Uri.parse(
          'http://192.168.0.101:8090/bus_link/api/protected/users/username/$email');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> mapDatos = jsonDecode(body);
        return mapDatos;
      } else {
        final body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> mapDatos = jsonDecode(body);
        return mapDatos;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<bool> isConnected() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
      return true;
    } else {
      print('No internet :( Reason:');
      return false;
    }
  }
}
