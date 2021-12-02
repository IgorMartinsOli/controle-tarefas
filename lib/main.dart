import 'package:app_ad/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Aplicativo de tarefas',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: HomeScreen(),
    /*initialRoute: "/",
    routes: {
      "/": (context) => HomeScreen(),
      "/cadastro": (context) => CadastroScreen(),
    },*/
  ));
}
