import 'dart:developer';
import 'dart:io';

import 'package:app_ad/database/sqlite/anuncio_helper.dart';
import 'package:app_ad/models/ad.dart';
import 'package:app_ad/screens/home_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CadastroAnuncio extends StatefulWidget {
  Ad? ad;

  CadastroAnuncio({this.ad});

  @override
  _CadastroAnuncioState createState() => _CadastroAnuncioState();
}

AdHelper _helper = AdHelper();

class _CadastroAnuncioState extends State<CadastroAnuncio> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _image;

  @override
  void initState() {
    super.initState();
    if (widget.ad != null) {
      setState(() {
        _titleController.text = widget.ad!.titulo;
        _descController.text = widget.ad!.descricao;
        _priceController.text = widget.ad!.preco.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Cadastro anuncios"),
        centerTitle: true,
      ),
      body: Column(children: [
        /*GestureDetector(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(width: 1, color: Colors.grey[400]!),
                    shape: BoxShape.circle),
                child: _image == null
                    ? const Icon(Icons.add_a_photo)
                    : CircleAvatar(
                        backgroundImage: FileImage(File(_image!)),
                      )),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);

              if (pickedFile != null) {
                File imagemOriginal = File(pickedFile.path);
                final directory = await getApplicationDocumentsDirectory();
                String _localPath = directory.path;
                String imageName = UniqueKey().toString();
                File imagemSalva = await imagemOriginal
                    .copy("$_localPath/image_$imageName.png");

                setState(() {
                  _image = imagemSalva.path;
                });
              }
            }),*/
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: TextFormField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    labelText: "Titulo",
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Preenchimento obrigatorio!";
                    }
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: TextFormField(
                  controller: _descController,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    labelText: "Descrição",
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Preenchimento obrigatorio!";
                    }
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: TextFormField(
                  controller: _priceController,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    labelText: "Valor",
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Preenchimento obrigatorio!";
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: widget.ad == null
                                ? Colors.green
                                : Colors.orange),
                        child: Text(widget.ad == null ? "Cadastrar" : "Editar",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Ad? ad = await _helper.newAd(
                                0,
                                _titleController.text,
                                _descController.text,
                                double.parse(_priceController.text));
                            if (ad != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: const Text("Cancelar",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
