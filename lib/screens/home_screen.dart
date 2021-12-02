import 'package:app_ad/models/ad.dart';
import 'package:flutter/material.dart';
import 'register_ad_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Ad> _lista = List.empty(growable: true);
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
                setState(() {
                  _lista.removeAt(index);
                });
              } else if (direction == DismissDirection.startToEnd) {
                Ad? editAd = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroAnuncio(ad: anuncio)));
                if (editAd != null) {
                  setState(() {
                    _lista.removeAt(index);
                    _lista.insert(index, editAd);
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
                  setState(() {
                    _lista.removeAt(index);
                    _lista.insert(index, editAd);
                  });
                }
                return false;
              } else if (direction == DismissDirection.endToStart) {
                return true;
              }
            },
            child: ListTile(
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
              onTap: () {
                setState(() {
                  anuncio.done = !anuncio.done;
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
              setState(() {
                _lista.add(newAd);
              });
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
