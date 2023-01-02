import 'dart:convert';

import 'package:http/http.dart' as http;

class UserServices {
  Future postLogin(String email, String password) async {
    try {
      var data = {'email': email, 'password': password};
      var url = Uri.parse(
          'http://192.168.0.100:8090/bus_link/api/auth/signin/client');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print(data["data"]["token"]);
        return data["data"];
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
