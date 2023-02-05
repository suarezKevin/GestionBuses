import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/bus_frecuencies.dart';
import 'package:mobil_app_bus/src/models/user_login.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:mobil_app_bus/src/screens/ticket_information_page.dart';
import 'package:mobil_app_bus/src/screens/tickets_page.dart';
import 'package:mobil_app_bus/src/services/frequencies_services.dart';
import 'package:mobil_app_bus/src/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  int _selected_index = 0;
  UserLogin? user;
  String? name;
  String? emailUser;
  List<String>? fullname;
  int sizeListFullname = 0;
  String? image;
  bool isConeccted = false;
  String travelType = "";
  Future<List<BusFrecuencies>>? frecuenciesList;
  TextEditingController? originController;
  TextEditingController? destinyController;
  String? originValue;
  String? destinyValue;
  String? client_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_rounded,
                size: 30,
              ),
            ),
            Flexible(
              child: Text(
                "Inicio / Bienvenido(a) $name",
                style: const TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
        backgroundColor: HexColor("#000080"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: HexColor("#4169E1"),
              ),
              accountName: Text("$name"),
              accountEmail: Text("$emailUser"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: HexColor("#000080"),
                child: Text(
                  "${fullname?[0][0]}${fullname?[sizeListFullname - 2][0]}",
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Cerrar Sesión'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("key_token", "");
                prefs.setString("key_email", "");
                prefs.setString("key_client_id", "");
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "¿A dónde deseas viajar?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(
                          left: 30, top: 10, right: 30, bottom: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#4169E1")),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white38,
                      ),
                      child: TextFormField(
                        controller: originController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Origen",
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        onSaved: (newValue) {
                          originValue = newValue;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo Obligatorio";
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(
                          left: 30, top: 10, right: 30, bottom: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#4169E1")),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white38,
                      ),
                      child: TextFormField(
                        controller: destinyController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Destino",
                          prefixIcon: const Icon(Icons.location_city),
                          suffixIcon: IconButton(
                              onPressed: () {
                                validateBusFrecuenciesList();
                              },
                              icon: const Icon(
                                Icons.search_rounded,
                                size: 40,
                                color: Colors.black87,
                              )),
                        ),
                        onSaved: (newValue) {
                          destinyValue = newValue;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo Obligatorio";
                          }
                        },
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: frecuenciesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BusFrecuencies> data =
                      snapshot.data as List<BusFrecuencies>;
                  if (data.isEmpty) {
                    return Column(children: const [
                      Text(
                        "¡Ups! No se encontraron resultados.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Verifique su búsqueda, por favor.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]);
                  }
                  return Expanded(
                    child: ListView(
                      children: showBusFrecuenciesList(data),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("Error");
                }
                return const Text("¡Inicie su búsqueda usando la lupa!");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: HexColor("#4169E1"),
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_membership_outlined,
              color: HexColor("#4169E1"),
            ),
            label: "Tickets",
          ),
        ],
        onTap: _pageSelect,
        currentIndex: _selected_index,
      ),
    );
  }

  void _pageSelect(int index) {
    setState(() {
      _selected_index = index;
      switch (_selected_index) {
        case 0:
          print("0");
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        case 1:
          print("1");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TicketsPage()),
          );
          break;

        default:
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserByEmail();
    checkInternet();
    setState(() {
      _selected_index = 0;
    });

    originController = TextEditingController();
    destinyController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    originController?.dispose();
    destinyController?.dispose();
  }

  Future<bool> checkInternet() async {
    isConeccted = await UserServices().isConnected();
    return isConeccted;
  }

  void validateBusFrecuenciesList() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      print(originValue);
      print(destinyValue);

      setState(() {
        frecuenciesList = getBusFrecuenciesList();
      });
      print(frecuenciesList);
    }
  }

  Future<List<BusFrecuencies>> getBusFrecuenciesList() async {
    var response = await BusFrequenciesServices()
        .getListBusFrecuencies(originValue!.trim(), destinyValue!.trim());

    return response;
  }

  Future getUserByEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString("key_email") ?? "";
    print(email);
    if (email.isNotEmpty) {
      var response = await UserServices().getUserByEmail(email);
      print(response);
      //response.toString().substring(0, 10) == "No internet"
      if (response == "Connection failed") {
        if (this.mounted) {
          setState(() {
            name = prefs.getString("key_fullname");
            emailUser = prefs.getString("key_email");
            fullname = name?.split(" ");
            sizeListFullname = fullname?.length as int;
          });
        }
      } else if (response == "Connection timed out") {
        if (this.mounted) {
          setState(() {
            name = prefs.getString("key_fullname");
            emailUser = prefs.getString("key_email");
            fullname = name?.split(" ");
            sizeListFullname = fullname?.length as int;
          });
        }
      } else if (response["message"] == "Cliente encontrado exitosamente") {
        print("exito");
        if (this.mounted) {
          setState(() {
            client_id = response["data"]["id"];
            user = UserLogin(
                fullName: response["data"]["full_name"],
                phone: response["data"]["phone"],
                city: response["data"]["city"],
                email: response["data"]["email"]);
            name = user?.getFullName;
            emailUser = user?.getEmail;
            fullname = name?.split(" ");
            sizeListFullname = fullname?.length as int;
            prefs.setString("key_fullname", name!);
            prefs.setString("key_client_id", response["data"]["id"]);
          });
        }
      }
    } else {
      print("Email vacio");
    }
  }

  List<Widget> showBusFrecuenciesList(List<BusFrecuencies> data) {
    List<Widget> frecuencies = [];
    for (var element in data) {
      BusFrecuencies busFrecuencies = element;
      Uint8List? imageBytes;
      if (element.image != null) {
        imageBytes = const Base64Decoder().convert(element.image.toString());
      }
      travelType = (element.type == "DIRECTO") ? "Si" : "No";
      frecuencies.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TicketInformationPage(
                      busFrecuencies: busFrecuencies, client_id: client_id)),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 15,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, top: 0, right: 15, bottom: 0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.cooperativeName.toString(), //nombre Cooperativa
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: HexColor("#4169E1"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Origen: ${element.origin}", // origen del viaje
                      ),
                      Text(
                        "Destino: ${element.destiny}", // destino del viaje
                      ),
                      Text(
                        "Precio: \$${element.price}", // precio del viaje
                      ),
                      Text(
                        "Duración: ${element.hours}h:${element.minutes}m aprox.", // duracion del viaje
                      ),
                      Text(
                        "Viaje Directo: $travelType", // Tipo de viaje
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return frecuencies;
  }
}
