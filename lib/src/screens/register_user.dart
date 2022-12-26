import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;

  bool _enableVisiblePassword = true;
  bool _enableConfirmPassword = true;

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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Cédula:",
                            ),
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Nombre:",
                            ),
                            maxLength: 40,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Teléfono:",
                            ),
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Ciudad:",
                            ),
                            maxLength: 30,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Nombre de Usuario:",
                            ),
                            maxLength: 30,
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _login(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Crear Cuenta"),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
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
}
