import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobil_app_bus/src/services/user_services.dart';

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
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _login(context);
                              _logInUser(context);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    print("Hola");
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

  void _logInUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      var _data = await UserServices().postLogin(emailValue!, passwordValue!);

      print(_data);
    }
  }
}
