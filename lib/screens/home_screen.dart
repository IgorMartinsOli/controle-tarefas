import 'dart:developer';

import 'package:app_ad/database/sqlite/login_helper.dart';
import 'package:app_ad/database/sqlite/anuncio_helper.dart';
import 'package:app_ad/models/ad.dart';
import 'package:app_ad/screens/login_screen.dart';
import 'package:app_ad/screens/register_ad_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Ad>> _posts;
  final AdHelper _helper = AdHelper();

  @override
  void initState() {
    super.initState();
    _posts = _helper.getAdsByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GERENCIADOR ANUNCIOS"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CadastroAnuncio()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              final loginHelper = LoginHelper();
              await loginHelper.logout();
              if (await loginHelper.isUserLogged() == false) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _helper.getAdsByUser(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List posts = snapshot.data!;
            return ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                    title: Text(
                      posts[index].titulo,
                      style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                    ),
                    subtitle: Text(
                      posts[index].descricao.replaceAll('\n', ' '),
                      textAlign: TextAlign.justify,
                    ),
                    onLongPress: () async {
                      final adHelper = AdHelper();
                      bool? retur = await adHelper.removeAd(posts[index].id);
                      if (retur == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        log('nao removeu');
                      }
                    },
                    isThreeLine: true,
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        const Icon(Icons.price_change),
                        Text(posts[index].preco.toString()),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
