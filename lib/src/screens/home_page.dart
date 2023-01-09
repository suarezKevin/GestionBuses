import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _elementSelect = 0;
  String textoVisualizar = "0: Home";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(229, 228, 226, 1)),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_rounded,
                  size: 30,
                ),
              ),
              const Flexible(
                child: Text(
                  "Inicio / Bienvenido Nombre Apellido",
                ),
              )
            ],
          ),
          backgroundColor: HexColor("#000080"),
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("key_token", "");
                  prefs.setString("key_email", "");
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                ))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
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
                        child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/c/c1/Bus-vector-design9.jpg",
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                          //color: Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cooperativa Baños",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: HexColor("#4169E1"),
                            ),
                          ),
                          // SizedBox(
                          //   width: 200,
                          //   height: 10,
                          //   child: Divider(
                          //     height: 1,
                          //     thickness: 1.5,
                          //     color: HexColor("#4169E1"),
                          //   ),
                          //),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Origen: Ambato",
                          ),
                          const Text(
                            "Destino: Santa Elena",
                          ),
                          const Text(
                            "Precio: \$13.50",
                          ),
                          const Text(
                            "Tipo de asiento: Normal",
                          ),
                          const Text(
                            "Viaje Directo: Si",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                Icons.supervised_user_circle,
                color: HexColor("#4169E1"),
              ),
              label: "Mi Cuenta",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assessment,
                color: HexColor("#4169E1"),
              ),
              label: "Estadisticas",
            ),
          ],
          currentIndex: _elementSelect,
          onTap: _itemSelect,
        ),
      ),
    );
  }

  void _itemSelect(int index) {
    setState(() {
      _elementSelect = index;
      switch (_elementSelect) {
        case 0:
          textoVisualizar = '$_elementSelect : Home';
          break;
        case 1:
          textoVisualizar = '$_elementSelect : Mi Cuenta';
          break;
        case 2:
          textoVisualizar = '$_elementSelect : Estadisticas';
          break;
        default:
      }
    });
  }
}
