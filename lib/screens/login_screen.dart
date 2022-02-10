import 'package:app_ad/database/sqlite/login_helper.dart';
import 'package:app_ad/models/user.dart';
import 'package:app_ad/screens/cadastrar_screen.dart';
import 'package:app_ad/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginHelper _helper = LoginHelper();

  /*@override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (await _helper.isUserLogged()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }*/

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
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[900]),
                          child: const Text(
                            "Ir para cadastro",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroScreen()));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blue[900]),
                        child: const Text(
                          "Logar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String? user = await _helper.login(
                                _telefoneController.text,
                                _passwordController.text);
                            if (user != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Usuário não encontrado!'),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
