import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:mobil_app_bus/src/models/passenger_account.dart';
import 'package:mobil_app_bus/src/services/user_services.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  bool _enableVisiblePassword = true;
  bool _enableConfirmPassword = true;

  FocusNode? ciFocus;
  FocusNode? nameFocus;
  FocusNode? phoneFocus;
  FocusNode? cityFocus;
  FocusNode? userNameFocus;
  FocusNode? passwordFocus;
  FocusNode? confirmPasswordFocus;

  PassengerAccount _passengerAccount = PassengerAccount();

  String? _passwordConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Transform.translate(
              offset: Offset(0, 0),
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
                      top: 40,
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
                            Text("Registrarse",
                                style: TextStyle(
                                  fontSize: 35,
                                  color: HexColor("#000080"),
                                  fontWeight: FontWeight.bold,
                                )),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Cédula:",
                              ),
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              focusNode: ciFocus,
                              onEditingComplete: () =>
                                  requestFocus(context, nameFocus!),
                              textInputAction: TextInputAction.next,
                              onSaved: (newValue) =>
                                  _passengerAccount.setCi = newValue!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "¡Campo Obligatorio!";
                                } else if (value.length <= 9) {
                                  return "¡Cédula incompleta!";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Nombre:",
                                hintText: "Alex Igancio Tigselema Pacheco",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              maxLength: 40,
                              focusNode: nameFocus,
                              onEditingComplete: () =>
                                  requestFocus(context, phoneFocus!),
                              textInputAction: TextInputAction.next,
                              onSaved: (newValue) =>
                                  _passengerAccount.setFullName = newValue!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "¡Campo Obligatorio!";
                                } else if (value.length <= 7) {
                                  return "¡Debe ingresar su nombre completo!";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Teléfono:",
                                hintText: "000 000 0000",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              focusNode: phoneFocus,
                              onEditingComplete: () =>
                                  requestFocus(context, cityFocus!),
                              textInputAction: TextInputAction.next,
                              onSaved: (newValue) =>
                                  _passengerAccount.setPhone = newValue!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "¡Campo Obligatorio!";
                                } else if (value.length <= 9) {
                                  return "¡Número incompleto!";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Ciudad:",
                                hintText: "Por Ejemplo: Ambato",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              maxLength: 30,
                              focusNode: cityFocus,
                              onEditingComplete: () =>
                                  requestFocus(context, userNameFocus!),
                              textInputAction: TextInputAction.next,
                              onSaved: (newValue) =>
                                  _passengerAccount.setCity = newValue!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "¡Campo Obligatorio!";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email:",
                                hintText: "usuario@gmail.com",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              maxLength: 30,
                              focusNode: userNameFocus,
                              onEditingComplete: () =>
                                  requestFocus(context, passwordFocus!),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) =>
                                  _passengerAccount.setEmail = newValue!,
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
                              decoration: InputDecoration(
                                  labelText: "Contraseña:",
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                      onTap: showPassword,
                                      child: Icon(_enableVisiblePassword
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility),
                                    ),
                                  )),
                              maxLength: 25,
                              obscureText: _enableVisiblePassword,
                              focusNode: passwordFocus,
                              onEditingComplete: () =>
                                  requestFocus(context, confirmPasswordFocus!),
                              textInputAction: TextInputAction.next,
                              onSaved: (newValue) =>
                                  _passengerAccount.setPassword = newValue!,
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
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Confirmar Contraseña:",
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: GestureDetector(
                                    onTap: showConfirmPassword,
                                    child: Icon(_enableConfirmPassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility),
                                  ),
                                ),
                              ),
                              obscureText: _enableConfirmPassword,
                              maxLength: 25,
                              focusNode: confirmPasswordFocus,
                              onSaved: (newValue) =>
                                  _passwordConfirm = newValue!,
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
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _createAccount(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Crear Cuenta"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "¿Ya tiene cuenta?",
                                ),
                                TextButton(
                                    onPressed: () {
                                      _showLogin(context);
                                    },
                                    child: Text("Iniciar Sesión"))
                              ],
                            ),
                          ],
                        ),
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

  void _showLogin(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/',
    );
  }

  void showConfirmPassword() {
    setState(() {
      _enableConfirmPassword = !_enableConfirmPassword;
    });
  }

  void showPassword() {
    setState(() {
      _enableVisiblePassword = !_enableVisiblePassword;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ciFocus = FocusNode();
    nameFocus = FocusNode();
    phoneFocus = FocusNode();
    cityFocus = FocusNode();
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ciFocus?.dispose();
    nameFocus?.dispose();
    phoneFocus?.dispose();
    cityFocus?.dispose();
    userNameFocus?.dispose();
    passwordFocus?.dispose();
    confirmPasswordFocus?.dispose();
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future _createAccount(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      print(_passengerAccount.password);

      print(_passwordConfirm);
      if (_passengerAccount.getPassword?.toLowerCase() ==
          _passwordConfirm?.toLowerCase()) {
        //validar que las contraseñas sean iguales
        var _data = await UserServices()
            .createAccount(_passengerAccount); //peticion a la api
        if (_data["httpStatusCode"].toString() == "201") {
          String full_name = _data["data"]["full_name"];
          print("Registro Exitoso aaaaaaaaaa");
          Navigator.pushReplacement(
            //llevar al usuario a la pagina de Login
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            //Mensaje de confirmacion de la cuenta creda
            SnackBar(
              content: Text(
                "¡Registro exitoso $full_name!",
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 4),
            ),
          );
        } else {
          print("Error al registrarse");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          //Mensaje de confirmacion de la cuenta creda
          SnackBar(
            content: Text(
              "¡Las contraseñas no son iguales!",
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
