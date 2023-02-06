import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mobil_app_bus/src/screens/tickets_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ReceiptSendPage extends StatefulWidget {
  ReceiptSendPage({super.key, this.ticket_id});
  String? ticket_id;

  @override
  State<ReceiptSendPage> createState() => _ReceiptSendPageState();
}

class _ReceiptSendPageState extends State<ReceiptSendPage> {
  File? imageF;
  bool showSpinner = false;

  Uint8List? imageBytes;

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    if (widget.ticket_id == "" || imageF == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("¡Primero debe cargar una imagen!"),
      ));
    } else {
      print(imageF.toString());
      print(widget.ticket_id.toString());

      var uri = Uri.parse(
          "https://buslink-backend-production.up.railway.app/bus_link/api/protected/tickets");
      var request = http.MultipartRequest("PUT", uri);

      request.headers["Content-Type"] = 'multipart/form-data';

      request.fields['id'] = widget.ticket_id.toString();
      //request.fields['receipt'] = imageBytes.toString();

      var multiport = http.MultipartFile(
        'receipt',
        imageF!.readAsBytes().asStream(),
        imageF!.lengthSync(),
        filename: imageF!.path.split('/').last,
      );

      request.files.add(multiport);
      try {
        var response = await request.send();

        response.stream.transform(utf8.decoder).listen((event) {
          print(event);
        });
        if (response.statusCode == 201) {
          setState(() {
            showSpinner = false;
          });
          showConfirmMessage();
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TicketsPage()),
          );
          print("Image uploaded");
        } else {
          setState(() {
            showSpinner = false;
          });
          print("Failed");
        }
      } catch (e) {
        e.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Subir Comprobante',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              imageF == null
                  ? Image.asset("assets/images/default.png",
                      height: 400, width: 350, fit: BoxFit.fill)
                  : Image.file(File(imageF!.path).absolute,
                      height: 400, width: 350, fit: BoxFit.fill),
              SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 14, color: Colors.white))),
                    onPressed: () async {
                      _selectImage();
                      setState(() {});
                    },
                    child: const Text(
                      'Cargar Imagen',
                      style: TextStyle(fontSize: 18),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 14, color: Colors.white))),
                    onPressed: () {
                      uploadImage();
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(fontSize: 18),
                    )),
              ]),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void showConfirmMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("¡Recibo enviado con éxito! Esperar confirmación."),
    ));
  }

  Future _selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Seleccionar imagen desde ...',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            imageF = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(imageF);
                            if (imageF != null) {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "¡No ha seleccionado una imagen!"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(MaterialCommunityIcons.image_multiple),
                                    const Text('Galería'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            imageF = await selectImageFromCamera();
                            if (imageF != null) {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("¡Sin captura de imagen!"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.camera_alt_rounded),
                                    Text('Cámara'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    final file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (file != null) {
      return File(file.path);
    } else {
      return null;
    }
  }

  //
  selectImageFromCamera() async {
    final file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 90);
    if (file != null) {
      return File(file.path);
    } else {
      return null;
    }
  }
}
