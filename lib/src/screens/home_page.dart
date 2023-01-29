import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/models/user_login.dart';
import 'package:mobil_app_bus/src/screens/login_page.dart';
import 'package:mobil_app_bus/src/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _elementSelect = 0;
  String textoVisualizar = "0: Home";
  UserLogin? user;
  String? name;
  String? emailUser;
  List<String>? fullname;
  int sizeListFullname = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(229, 228, 226, 1)),
      home: Scaffold(
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
                  style: TextStyle(fontSize: 15),
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
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Cerrar Sesión'),
                onTap: () async {
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
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "¿A dónde deseas viajar?",
                ),
              ),
              Container(
                height: 50,
                margin:
                    EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#4169E1")),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Origen",
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin:
                    EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#4169E1")),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Destino",
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserByEmail();
  }

  Future getUserByEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString("key_email") ?? "";
    print(email);
    if (email.isNotEmpty) {
      print(email + "hola");
      var response = await UserServices().getUserByEmail(email);
      print(response);
      print("hola");
      //response.toString().substring(0, 10) == "No internet"
      if (response == "Connection failed") {
        setState(() {
          name = prefs.getString("key_fullname");
          emailUser = prefs.getString("key_email");
          fullname = name?.split(" ");
          sizeListFullname = fullname?.length as int;
        });
      } else if (response == "Connection timed out") {
        setState(() {
          name = prefs.getString("key_fullname");
          emailUser = prefs.getString("key_email");
          fullname = name?.split(" ");
          sizeListFullname = fullname?.length as int;
        });
      } else if (response["message"] == "Cliente encontrado exitosamente") {
        print("exito");
        setState(() {
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
          //prefs.setString("key_email", emailUser!);
        });
      }
    } else {
      print("Email vacio");
    }
  }
}
