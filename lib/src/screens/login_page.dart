import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobil_app_bus/src/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  bool _enableVisiblePassword = true;

  FocusNode? usernameFocus;
  FocusNode? passwordFocus;

  String? emailValue;
  String? passwordValue;

  final formKey = GlobalKey<FormState>();

  TextEditingController? emailController;
  TextEditingController? passwordController;

  SharedPreferences? _prefs;

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor("#000080"),
                HexColor("#4169E1"),
              ]),
            ),
            child: Image.asset(
              "assets/images/imglogin.jpeg",
              width: double.infinity,
              height: 350,
              fit: BoxFit.fill,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 50),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 150,
                    bottom: 20,
                  ),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email:",
                              hintText: "usuario@gmail.com",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            maxLength: 30,
                            focusNode: usernameFocus,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(passwordFocus),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) {
                              emailValue = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obligatorio";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Formato de email no válido!";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: "Contraseña:",
                              hintText: "Mi contraseña",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: GestureDetector(
                                  onTap: showPassword,
                                  child: Icon(_enableVisiblePassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            obscureText: _enableVisiblePassword,
                            maxLength: 25,
                            focusNode: passwordFocus,
                            onSaved: (newValue) {
                              passwordValue = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obligatorio";
                              } else if (value.length <= 5 ||
                                  value.length >= 13) {
                                return "La contraseña debe tener entre 6 y 12 caracteres!";
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showHomePage(
                                  context); // llevar al usuario a la pagina principal
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Iniciar Sesión"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "¿No estás registrado?",
                              ),
                              TextButton(
                                  onPressed: () {
                                    _showRegister(context);
                                  },
                                  child: Text("Registrarse"))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/register',
    );
  }

  void _showHomePage(BuildContext context) async {
    if (await _logInUser(context)) {
      _login(context);
      Navigator.of(context).pushNamed(
        '/home_page',
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _loadPreferences();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameFocus?.dispose();
    passwordFocus?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
  }

  void showPassword() {
    setState(() {
      _enableVisiblePassword = !_enableVisiblePassword;
    });
  }

  Future _logInUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      var _data = await UserServices().postLogin(emailValue!, passwordValue!);
      print(passwordValue);
      print(emailValue);
      if (_data == "Connection timed out") {
        _showServerMessage(context);
        return false;
      } else if (_data == "Connection failed") {
        _showConnectionFailedMessage(context);
        return false;
      } else {
        if (_data["status"].toString() == "401") {
          print(_data["message"]);
          _showCredentialsErrorMessage(context);
          return false;
        } else {
          _prefs?.setString("key_token", _data["token"].toString());
          _prefs?.setString("key_email", _data["username"].toString());
          return true;
        }
      }
    }
    return false;
  }

  _showCredentialsErrorMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "¡Email o contraseña incorrecta!",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  _showServerMessage(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Servidor fuera de servicio"),
          content: Text(
              "¡Estamos trabajando para darte un mejor servicio! Sugerimos que lo intentes después."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  "Entendido",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _showConnectionFailedMessage(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Conexión Fallida"),
          content: Text("¡Revise su conexión a internet!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  "Entendido",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
