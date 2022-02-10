import 'package:app_ad/screens/home_screen.dart';
import 'package:app_ad/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Aplicativo de anuncios',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.amber,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.grey[600]!, fontSize: 22),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[700]!),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )),
      home: const LoginScreen()));
}
