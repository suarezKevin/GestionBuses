import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor("#000080"),
                HexColor("#4169E1"),
              ]),
            ),
            child: Image.asset(
              "assets/images/imglogin.jpeg",
              height: 200,
              width: 200,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 30),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Usuario:",
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Contraseña:",
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _login(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Iniciar Sesión"),
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
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "¿No estás registrado?",
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    '/register',
                                  );
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
}
