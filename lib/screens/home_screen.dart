import 'dart:io';

import 'package:app_ad/database/sqlite/anuncio_helper.dart';
import 'package:app_ad/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'register_ad_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Ad> _lista = List.empty(growable: true);
  //final FilePersistence _filePersistence = FilePersistence();
  AnuncioHelper _helper = AnuncioHelper();

  @override
  void initState() {
    super.initState();
    _helper.getAll().then((data) {
      setState(() {
        _lista = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Gerenciador de anuncios"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _lista.length,
        itemBuilder: (context, index) {
          Ad anuncio = _lista[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.yellow,
              child: const Align(
                alignment: Alignment(-0.8, 0.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment(0.8, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direction) async {
              if (direction == DismissDirection.endToStart) {
                int? qtd = await _helper.delete(anuncio);
                if (qtd != null && qtd > 0) {
                  setState(() {
                    _lista.removeAt(index);
                    const snackBar = SnackBar(
                        content: Text('Anúncio removido com sucesso!'),
                        backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                Ad? editAd = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroAnuncio(ad: anuncio)));
                if (editAd != null) {
                  int? qtd = await _helper.edit(editAd);
                  if (qtd != null && qtd > 0) {
                    setState(() {
                      _lista.removeAt(index);
                      _lista.insert(index, editAd);

                      const snackBar = SnackBar(
                        content: Text("Anuncio editado com sucesso"),
                        backgroundColor: Colors.yellow,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                }
                return false;
              } else if (direction == DismissDirection.endToStart) {
                return true;
              }
            },
            child: ListTile(
              leading: anuncio.image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(anuncio.image!)),
                    )
                  : const SizedBox(),
              title: Text(anuncio.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              subtitle: Text(anuncio.subTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  )),
              trailing: Text("R\$ ${anuncio.price}"),
              onLongPress: () async {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          height: 250,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                  leading: const Icon(Icons.email),
                                  title: const Text("Enviar por email"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final Uri params = Uri(
                                        scheme: "mailto",
                                        path: "igrmartoli@gmail.com",
                                        queryParameters: {
                                          "subject":
                                              "Duvidas sobre produto do app",
                                          "body":
                                              "Olá, tenho duvida em um produto anunciado no app."
                                        });

                                    final url = params.toString();
                                    if (!await launch(url.toString())) {
                                      throw 'não foi possivel abrir a url ${url}';
                                    }
                                  }),
                              ListTile(
                                  leading: const Icon(Icons.sms),
                                  title: const Text("Enviar por sms"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final Uri params = Uri(
                                        scheme: "sms",
                                        path: "+5564993001158",
                                        queryParameters: {
                                          "body":
                                              "Olá, tenho duvida em um produto anunciado no app."
                                        });

                                    final url = params.toString();
                                    if (!await launch(url)) {
                                      throw 'não foi possivel abrir a url ${url}';
                                    }
                                  }),
                              ListTile(
                                  leading: const Icon(Icons.cancel),
                                  title: const Text("Cancelar"),
                                  onTap: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ));
                    });
              },
            ),
          );
        },
        separatorBuilder: (context, itemBuilder) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          try {
            Ad? newAd = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroAnuncio()));

            if (newAd != null) {
              Ad? savedAd = await _helper.save(newAd);
              if (savedAd != null) {
                setState(() {
                  _lista.add(savedAd);
                  const SnackBar snackBar = SnackBar(
                    content: Text("Anunciado com sucesso"),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
            }
          } catch (error) {
            print("Error: ${error.toString()}");
          }
          print("Lista: ${_lista.toString()}");
        },
      ),
    );
  }
}
