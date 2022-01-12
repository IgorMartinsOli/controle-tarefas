import 'dart:io';

import 'package:app_ad/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroAnuncio extends StatefulWidget {
  Ad? ad;

  CadastroAnuncio({this.ad});

  @override
  _CadastroAnuncioState createState() => _CadastroAnuncioState();
}

class _CadastroAnuncioState extends State<CadastroAnuncio> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.ad != null) {
        _titleController.text = widget.ad!.title;
        _descController.text = widget.ad!.subTitle;
        _priceController.text = widget.ad!.price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    File? _image;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Cadastro anuncios"),
        centerTitle: true,
      ),
      body: Column(children: [
        GestureDetector(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(width: 1, color: Colors.grey[400]!),
                    shape: BoxShape.circle),
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 30)
                    : ClipOval(
                        child: Image.file(_image),
                      )),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);

              if (pickedFile != null) {
                _image = File(pickedFile.path);
              }
            }),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: TextFormField(
                  controller: _titleController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: TextFormField(
                  controller: _descController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: TextFormField(
                  controller: _priceController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Valor",
                    labelStyle: TextStyle(fontSize: 18),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: widget.ad == null
                                ? Colors.green
                                : Colors.orange),
                        child: Text(widget.ad == null ? "Cadastrar" : "Editar",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            if (widget.ad == null) {
                              Ad newAd = Ad(
                                _titleController.text,
                                _descController.text,
                                _priceController.text,
                              );
                              Navigator.pop(context, newAd);
                            } else {
                              widget.ad!.title = _titleController.text;
                              widget.ad!.subTitle = _descController.text;
                              widget.ad!.price = _priceController.text;
                              Navigator.pop(context, widget.ad);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text("Cancelar",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        onPressed: () {
                          Navigator.pop(context);
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
