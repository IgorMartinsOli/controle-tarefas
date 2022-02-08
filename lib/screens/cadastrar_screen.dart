import 'dart:developer';

import 'package:app_ad/database/sqlite/login_helper.dart';
import 'package:app_ad/models/user.dart';
import 'package:app_ad/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class CadastroScreen extends StatefulWidget {
  CadastroScreen({Key? key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  final LoginHelper _helper = LoginHelper();

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Gerenciador de anuncios"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[900],
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preenchimento obrigatório";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefoneController,
                  decoration: InputDecoration(
                      labelText: "Telefone",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[900],
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preenchimento obrigatório";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[900],
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preenchimento obrigatório";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User? user = await _helper.cadastrar(
                            _nomeController.text,
                            _telefoneController.text,
                            _passwordController.text);
                        if (user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Usuário não cadastrado!'),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                    child: const Text(
                      "ir para login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
