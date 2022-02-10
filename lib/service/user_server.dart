import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_ad/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> cadastrar(User user) async {
    String url = 'http://149.28.39.130:8080/usuario/';
    log('entrou no cadastrar');
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return user;
    } else if (response.statusCode == 500) {
      Exception("Erro ao executar a operação");
    }
  }

  Future<String?> logar(String telefone, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://149.28.39.130:8080/login/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        "telefone": telefone,
        "senha": password,
      },
    );
    if (response.statusCode == 200) {
      String token = (json.decode(response.body)['token'].toString());
      prefs.setString('token', token);
      return token;
    } else if (response.statusCode == 500) {
      Exception("Erro ao executar a operação");
    }
  }

  /*Future<User?> getUserByPhone(String phone, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = "${prefs.getString('phone')}${prefs.getString('password')}";
    const url = 'http://149.28.39.130:8080/login/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      List rList = jsonDecode(response.body);

      if (rList.length > 0) {
        User rUser = User.fromJson(rList.first);
        return rUser;
      } else {
        return null;
      }
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }*/
}
