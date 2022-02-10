import 'dart:developer';

import 'package:app_ad/models/user.dart';
import 'package:app_ad/service/user_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHelper {
  Future<String?> login(String phone, String password) async {
    UserService _service = UserService();
    String? token = await _service.logar(phone, password);
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("logged", true);
      return token;
    } else {
      await logout();
      return null;
    }
  }

  Future<User?> cadastrar(String nome, String phone, String password) async {
    UserService _service = UserService();
    int id = 0;
    User? userP = User(id: id, nome: nome, telefone: phone, senha: password);
    User? user = await _service.cadastrar(userP);
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("logged", true);
      prefs.setString("phone", user.telefone);
      prefs.setString("password", user.senha);
      return user;
    } else {
      await logout();
      return null;
    }
  }

  Future<bool> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged") == null ? false : prefs.getBool("logged")!;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged", false);
    prefs.remove("phone");
    prefs.remove("password");
  }
}
